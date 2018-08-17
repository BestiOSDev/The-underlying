//
//  NSObject+KVO.m
//  KVO底层原理
//
//  Created by dzb on 2018/7/9.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+KVO.h"

static NSString *const KVOAssociatedObservers = @"KVOAssociatedObservers";
static NSString *const KVOAssociatedOldValue = @"KVOAssociatedOldValue";

@implementation NSObject (KVO)

- (void) yv_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
	
	///获取当前类 isa 指向的 Class
	Class super_cls = object_getClass(self);
	///根据 keypath 生产一个 setter 方法
	SEL setterSel = NSSelectorFromString(setterForGetter(keyPath));
	if (!setterSel) return;
	Method method = class_getInstanceMethod(super_cls,setterSel);
	
	if (!method) {
		NSString *resason = [NSString stringWithFormat:@"Object %@ does not hava a setter for key %@",super_cls,keyPath];
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:resason userInfo:nil];
		return;
	}

	///动态创建子类  NSKVONotifying_xxx
	Class sub_cls = [self registerSubClassWithSuperClass:super_cls];
	
	///给子类动态的添加 class setter  didChangeValueForKey 实现
	Method class_method = class_getInstanceMethod(super_cls, @selector(class));
	Method changeValue_method = class_getInstanceMethod(super_cls, @selector(didChangeValueForKey:));
	
	class_addMethod(sub_cls, @selector(class), (IMP)kvo_class,method_getTypeEncoding(class_method));
	///给子类动态的添加 didChangeValueForKey
	class_addMethod(sub_cls, @selector(didChangeValueForKey:), (IMP)didChangeValue,method_getTypeEncoding(changeValue_method));
	///动态的给子类添加 setter 方法
	class_addMethod(sub_cls, setterSel, (IMP)kvo_setter,method_getTypeEncoding(method));
	
	///将观察者对象跟当前实例 self 关联起来
	objc_setAssociatedObject(self,(__bridge const void * _Nonnull)(KVOAssociatedObservers), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
}

/**
 运行时动态的创建子类

 @param super_cls 父类
 @return 返回子类
 */
- (Class) registerSubClassWithSuperClass:(Class)super_cls  {
	///动态的创建 子类
	NSString *clsName = [NSString stringWithFormat:@"NSKVONotifying_%@",super_cls];
	///一个 NSObject 默认分配16个字节内存
	Class sub_cls = objc_allocateClassPair(super_cls,clsName.UTF8String,16);
	///注册一个子类
	objc_registerClassPair(sub_cls);
	///将父类 isa 指针指向 子类
	object_setClass(self, sub_cls);
	return sub_cls;
}

/**
 自实现 class 方法

 @param self 当前类实现
 @param _cmd  class
 @return  返回父类 Class 外界不会知道 NSKVONotifying_子类存在
 */
static Class kvo_class(id self,SEL _cmd) {
	return class_getSuperclass(object_getClass(self));
}


/**
 自实现 setter 方法

 @param self 当前类实现
 @param _cmd  setter
 @param newValue  赋值
 */
static void kvo_setter(id self,SEL _cmd,id newValue) {
	
	NSString *setterName = NSStringFromSelector(_cmd);
	NSString *getterName = getterForSetter(setterName);

	///将要改变属性的值
	[self willChangeValueForKey:getterName];
	
	///调用 super setter 方法
	struct objc_super suer_cls = {
		.receiver = self,
		.super_class = class_getSuperclass(object_getClass(self))
	};
	///存储旧值
	objc_setAssociatedObject(self,(__bridge const void * _Nonnull)(KVOAssociatedOldValue),[self valueForKey:getterName], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	///调用父类 setter 方法 设置新值
	objc_msgSendSuper(&suer_cls,_cmd,newValue);
	///改变监听属性值后 调用 didChangeValueForKey 并在内部 调用
	[self didChangeValueForKey:getterName];
	
};


/**
 获取 getter方法名
 */
static NSString * getterForSetter(NSString *setter)
{
	if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
		return nil;
	}
	
	// remove 'set' at the begining and ':' at the end
	NSRange range = NSMakeRange(3, setter.length - 4);
	NSString *key = [setter substringWithRange:range];
	
	// lower case the first letter
	NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
	key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
									   withString:firstLetter];
	
	return key;
}

/**
 获取 setter 方法名
 @return <#return value description#>
 */
static NSString * setterForGetter(NSString *getter)
{
	if (getter.length <= 0) {
		return nil;
	}
	
	// upper case the first letter
	NSString *firstLetter = [[getter substringToIndex:1] uppercaseString];
	NSString *remainingLetters = [getter substringFromIndex:1];
	
	// add 'set' at the begining and ':' at the end
	NSString *setter = [NSString stringWithFormat:@"set%@%@:", firstLetter, remainingLetters];
	
	return setter;
}


/**
 didChangeValueForkey 实现方法 , 当根据 SEL (didChangeValueForkey:) 会找到方法 IMP 实现
 */
static void didChangeValue(id self,SEL _cmd,NSString *key) {
	
	id newValue = [self valueForKey:key];
	id observer = objc_getAssociatedObject(self,(__bridge const void * _Nonnull)(KVOAssociatedObservers));
	id oldValue = objc_getAssociatedObject(self,(__bridge const void * _Nonnull)(KVOAssociatedOldValue));
	
	NSMutableDictionary *change = [NSMutableDictionary dictionary];
	if (oldValue) {
		change[@"oldValue"] = oldValue;
	} else {
		change[@"oldValue"] = [NSNull null];
	}
	if (newValue) {
		change[@"newValue"] = newValue;
	} else {
		change[@"newValue"] = newValue;
	}
	
	[observer observeValueForKeyPath:key ofObject:self change:change context:NULL];

}

@end
