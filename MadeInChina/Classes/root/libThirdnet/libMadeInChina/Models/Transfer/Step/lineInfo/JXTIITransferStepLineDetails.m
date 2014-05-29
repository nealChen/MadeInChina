//
//  JXTIITransferStepLineDetails.m
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIITransferStepLineDetails.h"

@implementation JXTIITransferStepLineDetails

- (void)dealloc
{
    self.lineType = nil;
    self.name = nil;
    self.startTime = nil;
    self.endTime = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
