//
//  HashMap.m
//  HashTable
//
//  Created by dzb on 2018/7/9.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import "HashMap.h"

typedef int mask_t;

struct bucket_t {
	mask_t _key;
	__unsafe_unretained NSString *_name;
	__unsafe_unretained id _value;
};

struct cache_t {
	struct bucket_t *_buckets;
	mask_t _mask;
	mask_t _occupied;
};

@interface HashMap ()

@property (nonatomic,assign) struct cache_t cache;

@end

@implementation HashMap

- (HashMap *)initWithCapacity:(NSUInteger)numItems {
	if (self =  [super init]) {
		mask_t len = (mask_t)numItems;
		_cache._buckets = malloc(sizeof(struct bucket_t) * len);
		_cache._mask = len - 1;
		_cache._occupied = 0;
		for (int i = 0; i<len; i++) {
			_cache._buckets[i] = (struct bucket_t){0,nil,NULL};
		}
	}
	return self;
}

- (void)addObject:(id)obj forKey:(NSString *)key {
	
	if (!obj || !key) return;
	mask_t hashType = getKey(key);
	mask_t m = [self getIndexWith:hashType];
	if (m == -1) { return; }
	struct bucket_t bucket;
	bucket._name = key;
	bucket._key = hashType;
	_cache._occupied++;
	bucket._value = obj;
	_cache._buckets[m] = bucket;

}

- (id) objectForKey:(NSString *)key {
	if (!key) return nil;
	mask_t m = [self getIndexWith:getKey(key)];
	if (m == -1) { return nil; }
	struct bucket_t bucket = _cache._buckets[m];
	return bucket._value;
}

- (void)removeObjectsForKey:(NSString *)key {
	if (!key) return ;
	mask_t m = [self getIndexWith:getKey(key)];
	if (m == -1) { return;}
	struct bucket_t bt = _cache._buckets[m];
	if (bt._name ) {
		bt._name = nil;
		bt._value = NULL;
		bt._key = 0;
	}
}

- (NSArray *)allKeys {
	
	NSMutableArray *array = [NSMutableArray array];
	NSInteger count = _cache._mask + 1;
	for (int i = 0; i<count; i++) {
		struct bucket_t bt = _cache._buckets[i];
		if (bt._name != NULL) {
			[array addObject:bt._name];
			continue;
		}
	};
	
	return [array copy];
}

- (NSArray *)allValues {
	
	NSMutableArray *array = [NSMutableArray array];
	NSInteger count = _cache._mask + 1;
	for (int i = 0; i<count; i++) {
		struct bucket_t bt = _cache._buckets[i];
		if (bt._name != NULL) {
			id value = bt._value;
			[array addObject:value];
			continue;
		}
	};
	
	return [array copy];
}

static inline mask_t getKey(NSString *key) {
	int pt = (int)[key UTF8String];
	return abs(pt);
}

/**
 根据 key 生成一个索引 从_buckets取值
 */
- (mask_t) getIndexWith:(mask_t)hashType {
	mask_t begin = cache_hash(hashType,_cache._mask);
	mask_t i = begin;
	mask_t m = _cache._mask + 1; ///0 ... mask
	struct bucket_t *b = _cache._buckets;
	struct bucket_t tmp;
	do {
		tmp = b[i];
		if (tmp._key == 0 || tmp._key == hashType) {
			return i;
		}
	} while ((i = cache_next(i, m)) != begin);
	return -1;
}

/**
 根据 key 生产一个索引
 */
static inline mask_t cache_hash(mask_t key, mask_t mask)
{
	return (mask_t)(key & mask);
}

static inline mask_t cache_next(mask_t i, mask_t mask) {
	return i ? i-1 : mask;
}

- (NSInteger)count {
	return _cache._occupied;
}

- (NSString *)description {
	
	NSMutableString *string = [NSMutableString string];
	[string appendString:@"{\n"];
	NSInteger count = _cache._mask + 1;
	for (int i = 0; i<count; i++) {
		struct bucket_t bt = _cache._buckets[i];
		if (bt._name) {
			id value = bt._value;
			NSString *key = bt._name;
			[string appendFormat:@"\t%@ =  %@\n",key,value];
			continue;
		}
	}
	[string appendFormat:@"}\n"];
	return string;
}

- (void) freeBucktes {
	
	NSInteger count = _cache._mask+1;
	for (NSInteger i = 0; i<count; i++) {
		struct bucket_t bt = _cache._buckets[i];
		if (bt._name) {
			bt._name = nil;
			continue;
		}
	}
	
}

- (void)dealloc
{
	[self freeBucktes];
}

@end
