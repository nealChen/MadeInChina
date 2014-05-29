//
//  BMSubwayPlanModel.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-14.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIISubwayPlanModel.h"

@implementation JXTIISubwayPlanModel

- (void)dealloc
{
    self.throughStations = nil;
    self.firstTime1 = nil;
    self.lastTime1 = nil;
    self.firstTime2 = nil;
    self.lastTime2 = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
