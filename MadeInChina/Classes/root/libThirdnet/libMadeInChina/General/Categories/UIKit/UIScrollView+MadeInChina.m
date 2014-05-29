//
//  UIScrollView+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UIScrollView+MadeInChina.h"

@implementation UIScrollView (MadeInChina)

- (void)scrollToTop {
	[self scrollToTopAnimated:NO];
}


- (void)scrollToTopAnimated:(BOOL)animated {
	[self setContentOffset:CGPointMake(0.0f, 0.0f) animated:animated];
}

@end
