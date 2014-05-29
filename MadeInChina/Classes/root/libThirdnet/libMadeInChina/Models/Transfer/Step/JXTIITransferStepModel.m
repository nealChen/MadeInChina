//
//  JXTIITransferStepModel.m
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIITransferStepModel.h"

@implementation JXTIITransferStepModel

-(void)dealloc{
    
    self.direction = nil;
    self.stationName = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

-(void)setLongitudeByString:(NSString *)strLongitude{
    if (strLongitude && ![strLongitude isEqual:[NSNull null]]) {
        if (![strLongitude isEqual:@"(null)"] && ![strLongitude isEqual:@"<null>"]) {
            _longitude = [strLongitude doubleValue];
        }
    }
}

-(void)setLatitudeByString:(NSString *)strLatitude{
    if (strLatitude && ![strLatitude isEqual:[NSNull null]]) {
        if (![strLatitude isEqual:@"(null)"] && ![strLatitude isEqual:@"<null>"]) {
            _latitude = [strLatitude doubleValue];
        }
    }
}

@end
