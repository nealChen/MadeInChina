//
//  MICLog.h
//  BusMapII
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark -

typedef enum
{
	MICLogLevelNone			= 0,
	MICLogLevelInfo			= 100,
	MICLogLevelPerf			= 100 + 1,
	MICLogLevelProgress		= 100 + 2,
	MICLogLevelWarn			= 200,
	MICLogLevelError		= 300
} MICLogLevel;

//打印所有的subviews
void NSLogSubViewTree(UIView* view);

#pragma mark -

#undef	CC
#define CC( ... )			[[MICLogger sharedInstance] level:MICLogLevelNone format:__VA_ARGS__];

#undef	INFO
#define INFO( ... )			[[MICLogger sharedInstance] level:MICLogLevelInfo format:__VA_ARGS__];

#undef	PERF
#define PERF( ... )			[[MICLogger sharedInstance] level:MICLogLevelPerf format:__VA_ARGS__];

#undef	WARN
#define WARN( ... )			[[MICLogger sharedInstance] level:MICLogLevelWarn format:__VA_ARGS__];

#undef	ERROR
#define ERROR( ... )		[[MICLogger sharedInstance] level:MICLogLevelError format:__VA_ARGS__];

#undef	PROGRESS
#define PROGRESS( ... )		[[MICLogger sharedInstance] level:MICLogLevelProgress format:__VA_ARGS__];

#undef	VAR_DUMP
#define VAR_DUMP( __obj )	[[MICLogger sharedInstance] level:MICLogLevelNone format:[__obj description]];

#undef	OBJ_DUMP
#define OBJ_DUMP( __obj )	[[MICLogger sharedInstance] level:MICLogLevelNone format:[__obj objectToDictionary]];

#undef	TODO
#define TODO( desc, ... )

#pragma mark -

@interface MICBacklog : NSObject
@property (nonatomic, assign) MICLogLevel		level;
@property (nonatomic, retain) NSDate *			time;
@property (nonatomic, retain) NSString *		text;
@end

#pragma mark -

@interface MICLogger : NSObject

AS_SINGLETON( MICLogger );

@property (nonatomic, assign) BOOL				enabled;
@property (nonatomic, assign) BOOL				backlog;
@property (nonatomic, retain) NSMutableArray *	backlogs;
@property (nonatomic, assign) NSUInteger		indentTabs;

- (void)toggle;
- (void)enable;
- (void)disable;

- (void)indent;
- (void)indent:(NSUInteger)tabs;
- (void)unindent;
- (void)unindent:(NSUInteger)tabs;

- (void)level:(MICLogLevel)level format:(NSString *)format, ...;
- (void)level:(MICLogLevel)level format:(NSString *)format args:(va_list)args;

@end


#if __cplusplus
extern "C" {
#endif
    
	void MICLog( NSString * format, ... );
	
#if __cplusplus
};
#endif
