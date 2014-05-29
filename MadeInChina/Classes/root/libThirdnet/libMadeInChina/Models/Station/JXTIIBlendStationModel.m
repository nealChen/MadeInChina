//
//  JXTIIBlendStationModel.m
//  HzTraffic
//
//  Created by mac on 14-2-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIBlendStationModel.h"
#import "JXTIIWaterBusLineModel.h"

@implementation JXTIIBlendStationModel

- (void)dealloc
{
    self.intimateThings = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

-(NSString *)getAllStationName{

    NSMutableString *str = [NSMutableString string];
    for (id obj in self.intimateThings) {
        if ([obj isKindOfClass:[JXTIIStationModel class]]) {
            JXTIIStationModel *station = obj;
            [str appendFormat:str.length == 0 ? @"%@" : @",%@",station.name];
        }else if([obj isKindOfClass:[JXTIIWaterBusLineModel class]]){
            JXTIIWaterBusLineModel *waterBusLine = obj;
            [str appendFormat:str.length == 0 ? @"%@(%@-%@)" : @",\n%@(%@-%@)",
             waterBusLine.name,waterBusLine.startName,waterBusLine.endName];
            
        }else if ([obj isKindOfClass:[JXTIILineModel class]]){
            JXTIILineModel *line = obj;
            [str appendFormat:str.length == 0 ? @"%@" : @",%@",line.name];
        }
    }
    return str;
    
}

@end