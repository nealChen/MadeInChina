//
//  JXTIITransferStepBusModel.m
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIITransferStepBusModel.h"

@implementation JXTIITransferStepBusModel

- (void)dealloc
{
    self.stationName = nil;
    self.lineDetails = nil;
    self.lineTrails = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
