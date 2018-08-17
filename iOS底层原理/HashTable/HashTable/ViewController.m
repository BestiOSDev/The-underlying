//
//  ViewController.m
//  HashTable
//
//  Created by dzb on 2018/7/9.
//  Copyright © 2018 大兵布莱恩特. All rights reserved.
//

#import "HashMap.h"
#import "ViewController.h"

struct bucket_t {
	uintptr_t _ley;
	IMP _imp;
};

struct cache_t {
	struct bucket_t *_buckets;
	uint32_t _mask;
	uint32_t _occupied;
};

@interface ViewController ()

@end

@implementation ViewController


- (void) test {
	
}


- (void) eat {
	
	
}

- (void) doSomeThings {
	
	
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	
	
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		
		NSInteger count = 100000;
		NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:count];
		HashMap *hashMap = [[HashMap alloc] initWithCapacity:count];
		CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
		for (int i = 0; i<count; i++) {
			[dict setObject:@(i) forKey:@"name"];
//			[hashMap addObject:@(i) forKey:@"name"];
		}
		CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
		NSLog(@"%f", end-start);
//		NSLog(@"%@",hashMap);
	});

}




@end
