//
//  JXTIIFlightLineModel.h
//  HzTraffic
//
//  Created by swkj001023 on 14-3-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIIFlightLineModel : MICSQLBaseObject

@property (copy, nonatomic) NSString *startCode; //起点城市代码

@property (copy, nonatomic) NSString *endCode;  //终点城市代码

@property (copy, nonatomic) NSString *startCityName; //起点城市名称

@property (copy, nonatomic) NSString *destinationCityName; //起点城市名称

@property (copy, nonatomic) NSString *flightDate; //日期

//1--经济舱     2--公务舱    3--头等舱
@property (assign, nonatomic) int type;

/*
1--起飞时间排序（舱位按价格次之）
2--按价格排序（时间次之）
3--折扣优先（时间次之）
4--低价单一排序
*/
@property (assign, nonatomic) int sort;

@property (assign, nonatomic) BOOL asc;      //升序？

@property (assign, nonatomic) int pageSize;  //每页大小

@property (assign, nonatomic) int pageIndex; //页码

@property (retain, nonatomic) NSString *airlineCode; //航空公司代码

@property (retain, nonatomic) NSString *arrive; //到达的机场

@property (retain, nonatomic) NSString *flightClass; //舱位等级

@property (retain, nonatomic) NSString *craftType; //机型

@property (retain, nonatomic) NSString *flightCode; //航班号

@property (retain, nonatomic) NSString *depart;  //出发的机场

@property (retain, nonatomic) NSString *takeOffTime; //起飞时间

@property (retain, nonatomic) NSString *arriveTime; //抵达时间

@property (retain, nonatomic) NSString *displaySubclass; //显示用舱位

@property (retain, nonatomic) NSString *subClass;  //子舱位

@property (assign, nonatomic) double price; //航班票价

@property (assign, nonatomic) int quantity; //余票

@property (assign, nonatomic) double rate;  //航班折扣率

@property (assign, nonatomic) double standardPrice; //标准价

@property (assign, nonatomic) int stopTimes; //经停次数

@property (assign, nonatomic) double punctualityRate;    //参考准点率
/*
double BabyStandardPrice;  婴儿标准价
double ChildStandardPrice; 儿童标准价

 */

@end
