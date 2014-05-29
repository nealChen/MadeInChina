//
//  JXTIIStationTimeModel.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIStationTimeModel.h"

@implementation JXTIIStationTimeModel

- (void)dealloc
{
    self.startTime = nil;
    self.endTime = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
