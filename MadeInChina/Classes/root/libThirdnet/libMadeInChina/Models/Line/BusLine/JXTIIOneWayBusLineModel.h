//
//  JXTIIOneWayBusLineModel.h
//  HzTraffic
//
//  Created by mac on 14-2-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIILineModel.h"

@interface JXTIIOneWayBusLineModel : JXTIILineModel
//简称
@property (copy,nonatomic)NSString *shortName;

///票价
@property (assign,nonatomic)double price;
///季节票价
@property (assign,nonatomic)double seasonPrice;
///首班车
@property (copy,nonatomic)NSString *startTime;
///末班车
@property (copy,nonatomic)NSString *endTime;
///ic公交卡
@property (copy,nonatomic)NSString *icCard;

@end
