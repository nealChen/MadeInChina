//
//  JXTIIBusLineModel.m
//  JiaXingTrafficII
//
//  Created by mac on 13-9-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIBusLineModel.h"

@implementation JXTIIBusLineModel

- (id)init
{
    self = [super init];
    if (self) {
        self.lineId = -1;
        self.name = nil;
        self.type = -1;
        self.startName = nil;
        self.endName = nil;
        self.shortName = nil;
        self.lineType = nil;
        self.isRing = NO;
        self.upStartStationId = -1;
        self.upEndStationId = -1;
        self.downStartStationId = -1;
        self.downEndStationId = -1;
        self.price = -1.0f;
        self.lineUpStartTime = nil;
        self.lineUpEndTime = nil;
        self.lineDownStartTime = nil;
        self.lineDownEndTime = nil;
        self.upStartStationName = nil;
        self.upEndStationName = nil;
        self.downStartStationName = nil;
        self.downEndStationName = nil;
    }
    return self;
}

-(id)initWithLine:(id)line{
    self = [super init];
    if (self) {
        JXTIILineModel *t_line = line;
        self.lineId = t_line.lineId;
        self.name = t_line.name;
        self.type = t_line.type;
        self.startName = t_line.startName;
        self.endName = t_line.endName;
    }
    return self;
}
@end
