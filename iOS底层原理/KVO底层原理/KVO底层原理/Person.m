//
//  Person.m
//  KVO底层原理
//
//  Created by dzb on 2018/7/7.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <objc/runtime.h>
#import "Person.h"

@implementation Person

- (void)setName:(NSString *)name {
	_name = [name copy];
	NSLog(@"%s",__func__);
}
//
- (void)willChangeValueForKey:(NSString *)key {
	NSLog(@"willChangeValueForKey - begin");
	[super willChangeValueForKey:key];
	NSLog(@"willChangeValueForKey - end");
}
//
//- (void)didChangeValueForKey:(NSString *)key {
//	NSLog(@"didChangeValueForKey - begin");
//	[super didChangeValueForKey:key];
//	NSLog(@"didChangeValueForKey - end");
//}


@end
