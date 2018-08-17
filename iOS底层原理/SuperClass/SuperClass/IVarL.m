//
//  IVarL.m
//  SuperClass
//
//  Created by dzb on 2018/7/12.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import "IVarL.h"

@implementation IVarL

IVarL* IVarLMake(Ivar var) {
	IVarL *varL = [[IVarL alloc] init];
	varL->_ivar_offset = (int)ivar_getOffset(var);
	varL->_ivar_type = [NSString stringWithUTF8String:ivar_getTypeEncoding(var)];
	varL->_ivar_name = [NSString stringWithUTF8String:ivar_getName(var)];
	return varL;
}

- (NSString *)description {
	
	return nil;
}

@end
