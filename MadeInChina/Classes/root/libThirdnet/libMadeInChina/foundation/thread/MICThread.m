//
//  MICThread.m
//  MadeInChina
//
//  Created by swkj001152 on 14-5-7.
//  Copyright (c) 2014年 wgf. All rights reserved.
//

#import "MICThread.h"

@interface MICThread ()
{
    
    dispatch_queue_t    _foreQueue;
    dispatch_queue_t    _backQueue;
    
}
@end

@implementation MICThread

DEF_SINGLETON(MICThread)

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _foreQueue = dispatch_get_main_queue();
        _foreQueue = dispatch_queue_create(MIC_THREAD_NAME,
                                          DISPATCH_QUEUE_CONCURRENT);
        
    }
    return self;
}



+ (dispatch_queue_t)foreQueue
{
	return [[MICThread sharedInstance] foreQueue];
}

- (dispatch_queue_t)foreQueue
{
	return _foreQueue;
}

+ (dispatch_queue_t)backQueue
{
	return [[MICThread sharedInstance] backQueue];
}

- (dispatch_queue_t)backQueue
{
	return _backQueue;
}

+ (void)enqueueForeground:(dispatch_block_t)block
{
	return [[MICThread sharedInstance] enqueueForeground:block];
}

- (void)enqueueForeground:(dispatch_block_t)block
{
	dispatch_async( _foreQueue, block );
}

+ (void)enqueueBackground:(dispatch_block_t)block
{
	return [[MICThread sharedInstance] enqueueBackground:block];
}

- (void)enqueueBackground:(dispatch_block_t)block
{
	dispatch_async( _backQueue, block );
}

+ (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
	[[MICThread sharedInstance] enqueueForegroundWithDelay:ms block:block];
}

- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
	dispatch_after( time, _foreQueue, block );
}

+ (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
	[[MICThread sharedInstance] enqueueBackgroundWithDelay:ms block:block];
}

- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
	dispatch_after( time, _backQueue, block );
}

//- (MICThreadBlock)MAIN
//{
//	MICThreadBlock block = ^ MICThread * ( dispatch_block_t block )
//	{
//		[self enqueueForeground:block];
//		return self;
//	};
//    
//	return block;
//}
//
//- (MICThreadBlock)FORK
//{
//	MICThreadBlock block = ^ MICThread * ( dispatch_block_t block )
//	{
//		[self enqueueBackground:block];
//		return self;
//	};
//	
//	return block;
//
//}

@end
