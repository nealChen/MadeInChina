//
//  JXTIINearbyLiveTrafficStationModel.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIINearbyLiveTrafficStationModel.h"

@implementation JXTIINearbyLiveTrafficStationModel

- (void)dealloc
{
    self.url = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
