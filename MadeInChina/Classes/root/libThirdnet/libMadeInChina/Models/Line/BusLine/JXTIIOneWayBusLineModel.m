//
//  JXTIIOneWayBusLineModel.m
//  HzTraffic
//
//  Created by mac on 14-2-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIOneWayBusLineModel.h"

@implementation JXTIIOneWayBusLineModel

- (void)dealloc
{
    self.shortName = nil;
    self.startTime = nil;
    self.endTime = nil;
    self.icCard = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
