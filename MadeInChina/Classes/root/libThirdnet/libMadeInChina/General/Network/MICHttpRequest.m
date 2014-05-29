//
//  MICHttpRequest.m
//  BusMapII
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICHttpRequest.h"

@implementation MICHttpRequest

- (void)dealloc
{
    self.key = nil;
    self.path = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
