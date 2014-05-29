//
//  UIControl+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UIControl+MadeInChina.h"

@implementation UIControl (MadeInChina)

- (void)removeAllTargets {
	[[self allTargets] enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
		[self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
	}];
}

- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
	NSSet *targets = [self allTargets];
	for (id currentTarget in targets) {
		NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
		for (NSString *currentAction in actions) {
			[self removeTarget:currentTarget action:NSSelectorFromString(currentAction) forControlEvents:controlEvents];
		}
	}
	[self addTarget:target action:action forControlEvents:controlEvents];
}

@end
