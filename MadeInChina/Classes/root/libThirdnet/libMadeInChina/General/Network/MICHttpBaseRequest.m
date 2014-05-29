//
//  MICHttpBaseRequest.m
//  HzTraffic
//
//  Created by mac on 14-2-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICHttpBaseRequest.h"

@implementation MICHttpBaseRequest


- (void)dealloc
{
    self.safeInfo = nil;
    self.unSafeInfo = nil;
    self.serviceAddress = nil;
    self.httpRequestMethod = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
