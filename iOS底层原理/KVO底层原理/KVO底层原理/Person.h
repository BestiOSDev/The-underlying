//
//  Person.h
//  KVO底层原理
//
//  Created by dzb on 2018/7/7.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
	NSInteger _age;
}
///name
@property (nonatomic,copy) NSString *name;

@end
