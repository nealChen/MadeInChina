//
//  JXTIIWaterBusLineModel.h
//  HzTraffic
//
//  Created by swkj001152 on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIOneWayBusLineModel.h"

@interface JXTIIWaterBusLineModel : JXTIIOneWayBusLineModel

///票类型
@property (assign,nonatomic)int ticketType;
///线路类型
@property (copy,nonatomic)NSString *lineType;
///时间线
@property (copy,nonatomic)NSString *times;

@end
