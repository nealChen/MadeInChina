//
//  NSArray+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "NSArray+MadeInChina.h"
#import "NSMutableArray+MadeInChina.h"
#import "NSData+MadeInChina.h"

@interface NSArray (MadeInChinaPrivate)

- (NSData *)_prehashData;

@end

@implementation NSArray (MadeInChina)

- (id)firstObject {
	if ([self count] == 0) {
	    return nil;
	}
	
	return [self objectAtIndex:0];
}


- (id)randomObject {
	if ([self count] == 0) {
	    return nil;
	}
	
	return [self objectAtIndex:arc4random_uniform([self count])];
}

- (NSArray *)shuffledArray {
    NSMutableArray *array = [self mutableCopy];
    [array shuffle];
    return array;
}


- (NSMutableArray *)deepMutableCopy {
	return (__bridge NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFArrayRef)self, kCFPropertyListMutableContainers);
}


- (NSString *)MD5Sum {
	return [[self _prehashData] MD5Sum];
}


- (NSString *)SHA1Sum {
	return [[self _prehashData] SHA1Sum];
}

@end


@implementation NSArray (MadeInChinaPrivate)

- (NSData *)_prehashData {
	return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
}
@end
