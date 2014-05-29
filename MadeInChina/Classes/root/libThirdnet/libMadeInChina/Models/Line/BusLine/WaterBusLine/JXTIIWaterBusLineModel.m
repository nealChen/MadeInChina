//
//  JXTIIWaterBusLineModel.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIWaterBusLineModel.h"

@implementation JXTIIWaterBusLineModel

- (void)dealloc
{
    self.times = nil;
    self.lineType = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
