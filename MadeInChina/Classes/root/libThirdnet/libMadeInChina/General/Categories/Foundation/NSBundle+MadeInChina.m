//
//  NSBundle+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "NSBundle+MadeInChina.h"

@implementation NSBundle (MadeInChina)

+ (NSBundle *)MadeInChinaBundle {
	static NSBundle *ssToolkitBundle = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MadeInChinaResources.bundle"];
		ssToolkitBundle = [[NSBundle alloc] initWithPath:bundlePath];
	});
	return ssToolkitBundle;
}

@end
