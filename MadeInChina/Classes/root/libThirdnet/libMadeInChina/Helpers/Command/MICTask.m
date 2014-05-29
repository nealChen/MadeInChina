//
//  MICLetter.m
//  MadeInChina
//
//  Created by mac on 13-11-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICTask.h"

@implementation MICTask

- (void)dealloc
{
    NSLog(@"MICTask dealloc");
    self.name = nil;
    self.indexPath = nil;
    self.supply = nil;
//    self.task_block = nil;
    self.complete_block = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
