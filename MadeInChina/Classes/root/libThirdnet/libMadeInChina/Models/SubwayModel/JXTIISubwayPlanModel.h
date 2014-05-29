//
//  BMSubwayPlanModel.h
//  HzTraffic
//
//  Created by swkj001152 on 14-3-14.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIISubwayPlanModel : MICSQLBaseObject

///票价
@property (assign,nonatomic)double price;

///通过站点数量
@property (assign,nonatomic)int throughStationCount;
///通过站点
@property (strong,nonatomic)NSArray *throughStations;

///方向1
@property (assign,nonatomic)int direction1;
///首班车时间1
@property (copy,nonatomic)NSString *firstTime1;
///末班车时间1
@property (copy,nonatomic)NSString *lastTime1;

///方向2
@property (assign,nonatomic)int direction2;
///首班车时间2
@property (copy,nonatomic)NSString *firstTime2;
///末班车时间2
@property (copy,nonatomic)NSString *lastTime2;


@end
