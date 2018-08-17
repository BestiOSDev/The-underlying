//
//  Person.m
//  SuperClass
//
//  Created by dzb on 2018/7/6.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <objc/runtime.h>
#import "Person.h"

@implementation Person

- (void)test {
	NSLog(@"%s",__func__);
	
}

//- (Class)class {
//	return class_getSuperclass(object_getClass(self));
//}

@end
