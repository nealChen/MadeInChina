//
//  JXTIITransferStepLineTrails.m
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIITransferStepLineTrails.h"

@implementation JXTIITransferStepLineTrails

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
