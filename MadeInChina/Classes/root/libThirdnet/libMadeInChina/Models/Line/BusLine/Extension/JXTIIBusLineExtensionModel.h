//
//  JXTIIBusLineExtensionModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 mac. All rights reserved.
//

//#import "JXTIIBusLineModel.h"
#import "JXTIIOneWayBusLineModel.h"

@interface JXTIIBusLineExtensionModel : JXTIIOneWayBusLineModel

///第一辆到站信息
@property (nonatomic,strong)NSString *realTimeInfomation;
///第二辆到站信息
@property (nonatomic,strong)NSString *otherRealTimeInfo;
///第三辆到站信息
@property (nonatomic,strong)NSString *otherRealTimeInfo_1;

@end
