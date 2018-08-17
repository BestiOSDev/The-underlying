//
//  ViewController.m
//  KVO底层原理
//
//  Created by dzb on 2018/7/7.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <objc/runtime.h>
#import "Person.h"
#import "ViewController.h"
#import "NSObject+KVO.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	
	Person *p1 = [[Person alloc] init];
	Person *p2 = [[Person alloc] init];
	
//	id cls1 = object_getClass(p1);
//	id cls2 = object_getClass(p2);
//	NSLog(@"添加 KVO 之前: cls1 = %@  cls2 = %@ ",cls1,cls2);
	
	[p1 yv_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:NULL];
	
	NSLog(@"%@",[p1 class]);
	p1.name = @"dzb";
	
	p1.name = @"133";

	
	p2.name = @"hello";

	
}

- (NSString *) printPersonMethods:(id)obj {
	
	unsigned int count = 0;
	Method *methods = class_copyMethodList([obj class],&count);
	NSMutableString *methodList = [NSMutableString string];
	[methodList appendString:@"[\n"];
	for (int i = 0; i<count; i++) {
		Method method = methods[i];
		SEL sel = method_getName(method);
		[methodList appendFormat:@"%@",NSStringFromSelector(sel)];
		[methodList appendString:@"\n"];
	}
	
	[methodList appendFormat:@"]"];
	
	free(methods);
	
	return methodList;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
	NSLog(@"%@",change);
}




- (void)dealloc
{
	
}

@end
