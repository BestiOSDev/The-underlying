//
//  Student.m
//  SuperClass
//
//  Created by dzb on 2018/7/6.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "Student.h"

struct objc_super_ {
	__unsafe_unretained id receiver;
	Class superClass;
};

@implementation Student : Person




- (instancetype)init
{
	self = [super init];
	if (self) {
	
	
//		id obj1 = [self class];
//		id obj2 = [super class];
//
//		NSLog(@"%@",obj1);
//		NSLog(@"%@",obj2);
//
		
//		IMP imp = class_getMethodImplementation(object_getClass(self), @selector(class));
//
//
//		SEL sel = @selector(class);
//		Method m = class_getInstanceMethod(object_getClass(self),sel);
//		IMP imp = method_getImplementation(m);
//		id obj = imp(self,@selector(class));
//		NSLog(@"%@",obj);
//
//		struct objc_super_ sp = (struct objc_super_){self,class_getSuperclass([self class])};
//		id obj3 = objc_msgSendSuper((struct objc_super *)&sp,@selector(class));
//		NSLog(@"%@",obj3);
		
		
	
		
	}
	return self;
}


- (Class)class {
	return object_getClass(self);
}

@end
