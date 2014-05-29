//
//  Interfaces.h
//  HzTraffic
//
//  Created by mac on 14-1-14.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#ifndef HzTraffic_Interfaces_h
#define HzTraffic_Interfaces_h

#define kFunctionPostSubscribe @"PostSubscribe" //订阅接口
#define kFunctionDeleteSubscribe @"DeleteSubscribe" //取消订阅
#define kFunctionGetPushMessage @"GetPushMessage" //推送记录
#define kFunctionGetLatestInfo @"GetLatestInfo"
#define KFunctionQueryBusLine @"QueryBusLine"
#define KFunctionGetBusLine @"GetBusLine"
#define KFunctionGetBusArrive @"GetBusArrive"
#define KFunctionQueryBusStation @"QueryBusStation"
#define KFunctionGetBusStation @"GetBusStation"
#define KFunctionFindNearbyBusStation @"FindNearbyBusStation"//经纬度周边公交
#define KFunctionFindNearbyBikeStation @"FindNearbyBikeStation"//经纬度周边自行车
#define KFunctionFindQueryBikeParkingPlaceCount @"QueryBikeParkingPlaceCount" //自行车实时租凭情况
#define KFunctionQueryBikeStation @"QueryBikeStation"//自行车租凭点名称查询
#define KFunctionGetBikeStation @"GetBikeStation"
#define KFunctionGetBusTransfer @"GetBusTransfer"//公交换乘
#define KFunctionGetAssembledBusTransfer @"GetAssembledBusTransfer"//公交换乘拼接口
#define KFunctionQueryTrainByPlace @"QueryTrainByPlace"//火车
#define KFunctionQueryTrainNumberDetails @"QueryTrainNumberDetails"//火车车次查询
#define KFunctionGetComplaint @"GetComplaint"//查看投诉
#define KFunctionPostComplaint @"PostComplaint"//提交投诉
#define KFunctionQueryHighwayTollInfo @"QueryHighwayTollInfo"//查看普通公路费用基础数据

#define KFunctionGetSuperHighwayInfo @"GetSuperHighwayInfo"//高速路基础数据
#define KFunctionGetSuperHighwaySolution @"GetSuperHighwaySolution"//获取数据公路费用

#define KFunctionQQueryPassengerTransportStation @"QueryPassengerTransportStation"  //长途客运站点列表
#define KFunctionQueryPassengerTransportInfo @"QueryPassengerTransportInfo" //快速查询客运站点
#define KFunctionQueryPassengerTransport @"GetPassengerTransportInfo"//长途客运
#define KFunctionGetPassengerTransport @"GetPassengerTransport"//长运

#define KFunctionFindNearbyService @"FindNearbyService"//周边服务
#define KFunctionQueryNearbyService @"QueryNearbyService"//按名称搜索周边服务

#define KFunctionFindNearbyRoad @"FindNearbyRoad"//周边路况

#define KFunctionQueryWaterBusLine @"QueryWaterBusLine" //水上巴士线路查询
#define KFunctionGetWaterBusLine @"GetWaterBusLine"//水上巴士线路详情
#define KFunctionQueryWaterBusStation @"QueryWaterBusStation"//水上巴士站点查询
#define KFunctionGetWaterBusStation @"GetWaterBusStation"//水上巴士站点详情
#define KFunctionFindNearbyWaterBusStation @"FindNearbyWaterBusStation"//周边水上巴士

#define KFunctionGetAssembledTrafficTransfer @"GetAssembledTrafficTransfer"//市内换乘

#define KFunctionQuerySubwayLine @"QuerySubwayLine"//地铁线路查询
#define KFunctionGetSubwayLine @"GetSubwayLine"//地铁线路详情
#define KFunctionQuerySubwayStation @"QuerySubwayStation"//地铁站点查询
#define KFunctionGetSubwayStation @"GetSubwayStation"//地铁站点详情
#define KFunctionFindNearbySubwayStation @"FindNearbySubwayStation"//周边地铁
#define KFunctionGetSubwayPrice @"GetSubwayPrice"//地铁票价

#define KFunctionQueryAccident @"QueryAccident"//事故查询


#define KFunctionFindNearbyRoadVideo @"FindNearbyRoadVideo"//根据坐标查周边视屏图

#define KFunctionFindNearbyRoadCamera @"FindNearbyRoadCamera"  //根据坐标查周边路况摄像头
#define KQueryRoadCamera @"QueryRoadCamera" //获取全部摄像头
#define KFunctionQueryRoadWeather @"QueryRoadWeather"//天气
#define KFunctionGetWeather @"GetWeather" //获取天气

#define KFunctionGetAllWeiBo @"GetAllWeiBo" //获取全部weibo
#define KFunctionGetWeiBoByType @"GetWeiBoByType" //获取一种类型的weibo

#define KFunctionQuerySmallExpressDelivery @"QuerySmallExpressDelivery"//获取快递信息

#define KFunctionQueryParkingInfo @"QueryParkingInfo" //停车诱导
#define KFindNearbyParkingInfo @"FindNearbyParkingInfo"

#endif
