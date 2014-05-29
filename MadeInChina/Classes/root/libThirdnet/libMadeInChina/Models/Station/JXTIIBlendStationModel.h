//
//  JXTIIBlendStationModel.h
//  HzTraffic
//
//  Created by mac on 14-2-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIStationModel.h"

@interface JXTIIBlendStationModel : JXTIIStationModel

///站点类型
@property (assign,nonatomic)int stationType;

///站点关联信息
@property (strong,nonatomic)NSArray *intimateThings;


@end


@interface JXTIIBlendStationModel(StationNames)

-(NSString*)getAllStationName;

@end
