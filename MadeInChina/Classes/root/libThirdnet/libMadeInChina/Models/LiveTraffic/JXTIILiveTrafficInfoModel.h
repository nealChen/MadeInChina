//
//  JXTIILiveTrafficInfoModel.h
//  HzTraffic
//
//  Created by swkj001152 on 14-3-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIILiveTrafficInfoModel : MICSQLBaseObject

///"Direct":2147483647,方向，0正向，1反向
@property (assign,nonatomic)int direct;
///"DirectName":"String content",方向名，如南向北，东向西
@property (copy,nonatomic)NSString *directName;
///"Distance":当前位置离道路的距离
@property (assign,nonatomic)double distance;
///"Enable":true,是否可通行
@property (assign,nonatomic)BOOL enable;
///"EndName":"String content",结束路段名
@property (copy,nonatomic)NSString *endName;
///"Id":2147483647,路段编号
@property (assign,nonatomic)int number;
///"Length":1.26743233E+15,长度
@property (assign,nonatomic)double length;
///"Name":"String content",全程道路名
@property (copy,nonatomic)NSString *name;
///"Rank":"String content",等级
@property (copy,nonatomic)NSString *rank;
///"Speed":1.26743233E+15,速度
@property (assign,nonatomic)double speed;
///"StartName":"String content",开始路段名
@property (copy,nonatomic)NSString *startName;
///"UpdateTime":"String content"更新时间
@property (copy,nonatomic)NSString *updateTime;

//////经纬度信息
///纬度
@property (assign,nonatomic)double latitude;
///经度
@property (assign,nonatomic)double longitude;


@end
