//
//  IVarL.h
//  SuperClass
//
//  Created by dzb on 2018/7/12.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface IVarL : NSObject

@property (nonatomic,copy,readonly) NSString *ivar_name;
@property (nonatomic,copy,readonly) NSString *ivar_type;
@property (nonatomic,assign,readonly) int ivar_offset;

IVarL * IVarLMake(Ivar var);


@end
