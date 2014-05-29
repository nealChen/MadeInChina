//
//  UIScreen+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UIScreen+MadeInChina.h"

@implementation UIScreen (MadeInChina)

- (CGRect)currentBounds {
	return [self boundsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}


- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation {
	CGRect bounds = [self bounds];
    
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		CGFloat buffer = bounds.size.width;
        
		bounds.size.width = bounds.size.height;
		bounds.size.height = buffer;
	}
	return bounds;
}

- (BOOL)isRetinaDisplay {
	static dispatch_once_t predicate;
	static BOOL answer;
    
	dispatch_once(&predicate, ^{
		answer = ([self respondsToSelector:@selector(scale)] && [self scale] == 2);
	});
	return answer;
}

@end
