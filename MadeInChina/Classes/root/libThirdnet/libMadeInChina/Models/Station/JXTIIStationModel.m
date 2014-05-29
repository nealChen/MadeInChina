//
//  JXTIIStationModel.m
//  JiaXingTrafficII
//
//  Created by mac on 13-9-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIStationModel.h"

@implementation JXTIIStationModel

- (void)dealloc
{
    self.name = nil;
    self.alias = nil;
    self.address = nil;
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
