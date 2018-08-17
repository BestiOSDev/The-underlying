//
//  MethodL.h
//  SuperClass
//
//  Created by dzb on 2018/7/12.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface MethodL : NSObject

@property (nonatomic,assign) SEL method_name;
@property (nonatomic,copy) NSString *method_types;
@property (nonatomic,assign) IMP method_imp;

MethodL * MethodLMake(Method method);

@end
