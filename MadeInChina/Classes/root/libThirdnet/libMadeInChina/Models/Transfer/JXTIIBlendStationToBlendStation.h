//
//  JXTIIBlendStationToBlendStation.h
//  HzTraffic
//
//  Created by mac on 14-2-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"
#import "JXTIIBlendStationModel.h"

@interface JXTIIBlendStationToBlendStation : MICSQLBaseObject

///起点
@property (strong,nonatomic)JXTIIBlendStationModel *startStation;
///终点
@property (strong,nonatomic)JXTIIBlendStationModel *endStation;

@end
