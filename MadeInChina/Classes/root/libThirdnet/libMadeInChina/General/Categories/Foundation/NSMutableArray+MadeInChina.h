//
//  NSMutableArray+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 Provides extensions to `NSMutableArray` for various common tasks.
 */
@interface NSMutableArray(MadeInChina)
///--------------------------
/// @name Changing the Array
///--------------------------

/**
 Shuffles the elements of this array in-place using the Fisher-Yates algorithm
 
 */
- (void)shuffle;

+ (NSMutableArray *)nonRetainingArray;			// copy from Three20

- (NSMutableArray *)pushHead:(NSObject *)obj;
- (NSMutableArray *)pushHeadN:(NSArray *)all;
- (NSMutableArray *)popTail;
- (NSMutableArray *)popTailN:(NSUInteger)n;

- (NSMutableArray *)pushTail:(NSObject *)obj;
- (NSMutableArray *)pushTailN:(NSArray *)all;
- (NSMutableArray *)popHead;
- (NSMutableArray *)popHeadN:(NSUInteger)n;

- (NSMutableArray *)keepHead:(NSUInteger)n;
- (NSMutableArray *)keepTail:(NSUInteger)n;

//- (void)insertObjectNoRetain:(id)anObject atIndex:(NSUInteger)index;
//- (void)addObjectNoRetain:(NSObject *)obj;
//- (void)removeObjectNoRelease:(NSObject *)obj;
//- (void)removeAllObjectsNoRelease;


@end
