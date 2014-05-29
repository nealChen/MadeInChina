//
//  NSNumber+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "NSNumber+MadeInChina.h"

@implementation NSNumber (MadeInChina)

- (NSDate *)dateValue
{
	NSTimeInterval timestamp = [self doubleValue];
	if (!timestamp) {
		return nil;
	}
	return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

@end
