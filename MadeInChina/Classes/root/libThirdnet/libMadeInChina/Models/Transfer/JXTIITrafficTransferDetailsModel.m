//
//  JXTIITrafficTransferDetailsModel.m
//  HzTraffic
//
//  Created by mac on 14-2-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIITrafficTransferDetailsModel.h"

@implementation JXTIITrafficTransferDetailsModel

-(void)dealloc{
    self.title = nil;
    self.arrayLineName = nil;
    self.arrayStep = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

-(NSString *)allLineName{
    
    NSMutableString *allLines = [NSMutableString string];
    
    for (NSString *lineName in self.arrayLineName) {
        [allLines appendFormat:allLines.length > 0 ? @" ⇀ %@" : @"%@" ,lineName];
    }
    
    return allLines;
}

@end
