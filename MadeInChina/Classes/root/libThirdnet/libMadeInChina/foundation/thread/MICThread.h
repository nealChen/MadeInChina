//
//  MICThread.h
//  MadeInChina
//
//  Created by swkj001152 on 14-5-7.
//  Copyright (c) 2014年 wgf. All rights reserved.
//
@import Foundation;

/**
 *  线程名
 */
const char * const MIC_THREAD_NAME = "com.MadeInChina.taskQueue";


@class MICThread;
@compatibility_alias MICTaskQueue MICThread;

typedef MICThread * (^MICThreadBlock)( dispatch_block_t block );

@interface MICThread : NSObject

//@property (nonatomic, readonly) MICThreadBlock	MAIN;
//@property (nonatomic, readonly) MICThreadBlock	FORK;

AS_SINGLETON(MICThread)

+ (dispatch_queue_t)foreQueue;
+ (dispatch_queue_t)backQueue;

+ (void)enqueueForeground:(dispatch_block_t)block;
+ (void)enqueueBackground:(dispatch_block_t)block;
+ (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;
+ (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;

@end

