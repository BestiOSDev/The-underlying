//
//  MethodL.m
//  SuperClass
//
//  Created by dzb on 2018/7/12.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import "MethodL.h"

@implementation MethodL

MethodL * MethodLMake(Method method) {
	MethodL *m = [[MethodL alloc] init];
	m.method_name = method_getName(method);
	m.method_imp = method_getImplementation(method);
	m.method_types = [NSString stringWithUTF8String:method_getTypeEncoding(method)];
	return m;
}

@end
