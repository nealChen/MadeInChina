//
//  MICLog.m
//  BusMapII
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICLog.h"
#import "NSMutableArray+MadeInChina.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

#undef	MAX_BACKLOG
#define MAX_BACKLOG	(50)



void NSLogSubViewTreeWithLevel(UIView* view,int level){

    char c_level[level+1] ;
    memset(c_level, 0, level+1);
    memset(c_level, 45, level);
//    printf("\n%s\n",c_level);

    for (UIView* subview in view.subviews) {
        NSLog(@" |-%@%@",[NSString stringWithUTF8String:c_level],subview);
        NSLogSubViewTreeWithLevel(subview, level+1);
    }
}

void NSLogSubViewTree(UIView* view){
    NSLogSubViewTreeWithLevel(view, 0);
}

#pragma mark -

@implementation MICBacklog

@synthesize level = _level;
@synthesize time = _time;
@synthesize text = _text;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.level = MICLogLevelNone;
		self.time = [NSDate date];
		self.text = nil;
	}
	return self;
}

- (void)dealloc
{
	self.time = nil;
	self.text = nil;
	
	[super dealloc];
}

@end

#pragma mark -

@interface MICLogger()
{
	BOOL				_enabled;
	BOOL				_backlog;
	NSMutableArray *	_backlogs;
	NSUInteger			_indentTabs;
}
@end

#pragma mark -

@implementation MICLogger

DEF_SINGLETON( MICLogger );

@synthesize enabled = _enabled;
@synthesize backlog = _backlog;
@synthesize backlogs = _backlogs;
@synthesize indentTabs = _indentTabs;

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.enabled = YES;
		self.backlog = YES;
		self.backlogs = [NSMutableArray array];
		self.indentTabs = 0;
	}
	return self;
}

- (void)dealloc
{
	self.backlogs = nil;
	
	[super dealloc];
}

- (void)toggle
{
	_enabled = _enabled ? NO : YES;
}

- (void)enable
{
	_enabled = YES;
}

- (void)disable
{
	_enabled = YES;
}

- (void)indent
{
	_indentTabs += 1;
}

- (void)indent:(NSUInteger)tabs
{
	_indentTabs += tabs;
}

- (void)unindent
{
	if ( _indentTabs > 0 )
	{
		_indentTabs -= 1;
	}
}

- (void)unindent:(NSUInteger)tabs
{
	if ( _indentTabs < tabs )
	{
		_indentTabs = 0;
	}
	else
	{
		_indentTabs -= tabs;
	}
}

- (void)level:(MICLogLevel)level format:(NSString *)format, ...
{
//#if (__ON__ == __BEE_LOG__)
	
	if ( nil == format || NO == [format isKindOfClass:[NSString class]] )
		return;
    
	va_list args;
	va_start( args, format );
	
	[self level:level format:format args:args];
    
	va_end( args );
	
//#endif	// #if (__ON__ == __BEE_LOG__)
}

- (void)level:(MICLogLevel)level format:(NSString *)format args:(va_list)args
{
//#if (__ON__ == __BEE_LOG__)
	
	if ( NO == _enabled )
		return;
	
	// formatting
	
	NSString * prefix = nil;
	
	if ( MICLogLevelInfo == level )
	{
		prefix = @"INFO";
	}
	else if ( MICLogLevelPerf == level )
	{
		prefix = @"PERF";
	}
	else if ( MICLogLevelWarn == level )
	{
		prefix = @"WARN";
	}
	else if ( MICLogLevelError == level )
	{
		prefix = @"ERROR";
	}
	
	if ( prefix )
	{
		prefix = [NSString stringWithFormat:@"[%@]", prefix];
		prefix = [prefix stringByPaddingToLength:8 withString:@" " startingAtIndex:0];
	}
	
	NSMutableString * tabs = nil;
	NSMutableString * text = nil;
	
	if ( _indentTabs > 0 )
	{
		tabs = [NSMutableString string];
		
		for ( int i = 0; i < _indentTabs; ++i )
		{
			[tabs appendString:@"\t"];
		}
	}
	
	text = [NSMutableString string];
	
	if ( prefix && prefix.length )
	{
		[text appendString:prefix];
	}
	
	if ( tabs && tabs.length )
	{
		[text appendString:tabs];
	}
	
	if ( MICLogLevelProgress == level )
	{
		NSString *	name = [format stringByPaddingToLength:32 withString:@" " startingAtIndex:0];
		NSString *	state = va_arg( args, NSString * );
		
		[text appendFormat:@"%@\t\t\t\t[%@]", name, state];
	}
	else
	{
		NSString * content = [[[NSString alloc] initWithFormat:(NSString *)format arguments:args] autorelease];
		if ( content && content.length )
		{
			[text appendString:content];
		}
	}
	
	if ( [text rangeOfString:@"\n"].length )
	{
		[text replaceOccurrencesOfString:@"\n"
							  withString:[NSString stringWithFormat:@"\n%@", tabs ? tabs : @"\t\t"]
								 options:NSCaseInsensitiveSearch
								   range:NSMakeRange( 0, text.length )];
	}
	
	// print to console
	
	fprintf( stderr, [text UTF8String], NULL );
	fprintf( stderr, "\n", NULL );
	
	// back log
	
	if ( _backlog )
	{
		MICBacklog * log = [[[MICBacklog alloc] init] autorelease];
		log.level = level;
		log.text = text;
		
		[_backlogs pushTail:log];
		[_backlogs keepTail:MAX_BACKLOG];
	}
	
//#endif	// #if (__ON__ == __BEE_LOG__)
}

@end

#if __cplusplus
extern "C" {
#endif
void MICLog( NSString * format, ... )
{
//#if (__ON__ == __BEE_LOG__)
	
	if ( nil == format || NO == [format isKindOfClass:[NSString class]] )
		return;
	
	va_list args;
	va_start( args, format );
	
	[[MICLogger sharedInstance] level:MICLogLevelInfo format:format args:args];
	
	va_end( args );
	
//#endif	// #if (__ON__ == __BEE_LOG__)
}
#if __cplusplus
};
#endif

