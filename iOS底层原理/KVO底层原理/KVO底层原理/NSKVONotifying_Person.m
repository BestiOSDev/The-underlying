//
//  NSKVONotifying_Person.m
//  KVO底层原理
//
//  Created by dzb on 2018/7/7.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import "NSKVONotifying_Person.h"

@implementation NSKVONotifying_Person

- (void)setName:(NSString *)name {
	_NSSetObjectValueAndNotify();
}

- (void)willChangeValueForKey:(NSString *)key {
	NSLog(@"willChangeValueForKey");
	[super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
	[super didChangeValueForKey:key];
	[observer observeValueForKeyPath:@"name" ]
}

void _NSSetObjectValueAndNotify() {
	
	[self willChangeValueForKey:@"name"];
	[super setNmae:name];
	[self didChangeValueForKey:@"name"];
}

- (Class)class {
	return class_getSuperclass(object_getClass(self));
}

@end
