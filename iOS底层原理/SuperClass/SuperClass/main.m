//
//  main.m
//  SuperClass
//
//  Created by dzb on 2018/7/6.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import "Person.h"
#import "Student.h"
#import <objc/runtime.h>
#import "IVarL.h"
#import "MethodL.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		Student *st = [[Student alloc] init];
		st.name = @"NSStringNSStringNSStringNSStringNSStringNSStringNSString";

	}
	return 0;
}
