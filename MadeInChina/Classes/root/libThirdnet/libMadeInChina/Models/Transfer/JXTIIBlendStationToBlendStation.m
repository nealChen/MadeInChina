//
//  JXTIIBlendStationToBlendStation.m
//  HzTraffic
//
//  Created by mac on 14-2-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIBlendStationToBlendStation.h"

@implementation JXTIIBlendStationToBlendStation

- (void)dealloc
{
    self.startStation = nil;
    self.endStation = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
    
}

@end
