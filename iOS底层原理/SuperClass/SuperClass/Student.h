//
//  Student.h
//  SuperClass
//
//  Created by dzb on 2018/7/6.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import "Person.h"

@interface Student : Person

@property (nonatomic,copy) NSString *name;
///int
@property (nonatomic,strong) NSNumber *a;

- (void) test;
- (void) run;

@end
