//
//  NSObject+KVO.h
//  KVO底层原理
//
//  Created by dzb on 2018/7/9.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

- (void) yv_addObserver:(NSObject *_Nonnull)observer forKeyPath:(NSString *_Nullable)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;


@end
