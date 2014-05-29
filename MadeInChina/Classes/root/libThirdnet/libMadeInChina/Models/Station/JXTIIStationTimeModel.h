//
//  JXTIIStationTimeModel.h
//  HzTraffic
//
//  Created by swkj001152 on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIStationModel.h"

@interface JXTIIStationTimeModel : JXTIIStationModel
///首发时间
@property (copy,nonatomic)NSString *startTime;
///末班车时间
@property (copy,nonatomic)NSString *endTime;
@end
