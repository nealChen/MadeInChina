//
//  JXTIIFlightLineModel.m
//  HzTraffic
//
//  Created by swkj001023 on 14-3-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIFlightLineModel.h"

@implementation JXTIIFlightLineModel

- (void)dealloc
{
    self.startCode = nil;
    self.endCode = nil;
    self.startCityName = nil;
    self.destinationCityName = nil;
    self.flightDate = nil;
    self.airlineCode = nil;
    self.arrive = nil;
    self.flightClass = nil;
    self.craftType = nil;
    self.flightCode = nil;
    self.depart = nil;
    self.takeOffTime = nil;
    self.arriveTime = nil;
    self.displaySubclass = nil;
    self.subClass = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
