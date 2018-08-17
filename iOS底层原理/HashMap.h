//
//  HashMap.h
//  HashTable
//
//  Created by dzb on 2018/7/9.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashMap <__covariant KeyType, __covariant ObjectType> : NSObject

- (HashMap *) initWithCapacity:(NSUInteger)numItems;

- (void) addObject:(ObjectType)obj forKey:(KeyType)key;

- (ObjectType) objectForKey:(KeyType)key;

- (void) removeObjectsForKey:(KeyType)key;

- (NSInteger) count;

@property (readonly, copy) NSArray<KeyType> *allKeys;
@property (readonly, copy) NSArray<KeyType> *allValues;

@end
