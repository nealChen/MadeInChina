//
//  UIScrollView+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MadeInChina)

///----------------
/// @name Scrolling
///----------------

/**
 Scroll to the top of the receiver without animation.
 */
- (void)scrollToTop;

/**
 Scroll to the top of the receiver.
 
 @param animated `YES` to animate the transition at a constant velocity to the new offset, `NO` to make the transition immediate.
 */
- (void)scrollToTopAnimated:(BOOL)animated;

@end
