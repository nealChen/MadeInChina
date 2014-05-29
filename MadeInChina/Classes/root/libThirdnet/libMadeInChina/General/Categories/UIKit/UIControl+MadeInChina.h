//
//  UIControl+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Provides extensions to `UIControl` for various common tasks.
 */
@interface UIControl (MadeInChina)
/**
 Removes all targets and actions for all events from an internal dispatch table.
 */
- (void)removeAllTargets;

/**
 Sets exclusive target for specified event, all previous targets will be removed, usefull for table cells etc
 */
- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
