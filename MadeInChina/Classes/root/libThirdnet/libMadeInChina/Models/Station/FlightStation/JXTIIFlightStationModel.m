//
//  JXTIIFlightStationModel.m
//  HzTraffic
//
//  Created by swkj001023 on 14-4-1.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIFlightStationModel.h"

@implementation JXTIIFlightStationModel

- (void)dealloc
{
    self.code = nil;
    
#if ! __has_feature(objc_arc)
//#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
    
}

@end
