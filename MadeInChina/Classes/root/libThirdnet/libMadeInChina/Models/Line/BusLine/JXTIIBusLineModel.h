//
//  JXTIIBusLineModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-9-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIILineModel.h"

@interface JXTIIBusLineModel : JXTIILineModel

///线路简称
@property (strong,nonatomic) NSString *shortName;
///线路类型
@property (strong,nonatomic) NSString *lineType;
///是否环路
@property (assign,nonatomic) BOOL isRing;
///上行起点站编号
@property (assign,nonatomic) int upStartStationId;
///上行终点站编号
@property (assign,nonatomic) int upEndStationId;
///下行起点站编号
@property (assign,nonatomic) int downStartStationId;
///下行终点站编号
@property (assign,nonatomic) int downEndStationId;
//空调票价
@property (assign,nonatomic) double price;
/*
 略
 NormalPrice	double?	普通车票价
 SeasonPrice	double?	季节票价
 IcCard	string	ic卡使用情况
 */
///上行首班时间
@property (strong,nonatomic) NSString *lineUpStartTime;
///上行末班时间
@property (strong,nonatomic) NSString *lineUpEndTime;
///下行首班时间
@property (strong,nonatomic) NSString *lineDownStartTime;
///下行末班时间
@property (strong,nonatomic) NSString *lineDownEndTime;
///上行起点站名
@property (strong,nonatomic) NSString *upStartStationName;
///上行终点站名
@property (strong,nonatomic) NSString *upEndStationName;
///下行起点站名
@property (strong,nonatomic) NSString *downStartStationName;
///下行终点站名
@property (strong,nonatomic) NSString *downEndStationName;
/*
 略
 Remark	string	备注
 */

///快速初始化
-(id)initWithLine:(id)line;

@end
