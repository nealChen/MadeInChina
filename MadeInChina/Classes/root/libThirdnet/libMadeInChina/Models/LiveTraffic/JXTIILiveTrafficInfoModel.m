//
//  JXTIILiveTrafficInfoModel.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIILiveTrafficInfoModel.h"

@implementation JXTIILiveTrafficInfoModel

- (void)dealloc
{
    self.directName = nil;
    self.endName = nil;
    self.name = nil;
    self.rank = nil;
    self.startName = nil;
    self.updateTime = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
