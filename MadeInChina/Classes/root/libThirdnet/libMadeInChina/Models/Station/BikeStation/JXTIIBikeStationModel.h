//
//  JXTIIBikeStationModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIStationModel.h"

@interface JXTIIBikeStationModel : JXTIIStationModel

///区域名称
@property (strong, nonatomic)NSString *areaName;
///总车位数量
@property (assign, nonatomic)int count;
///服务时间
@property (strong, nonatomic)NSString *serviceTime;
///是否全天
@property (assign, nonatomic)int isAllDay;
///是否有人服务
@property (assign, nonatomic)BOOL isPersonDuty;
///站点电话
@property (strong, nonatomic)NSString *stationPhone;

-(void)setStationPhoneOfStrong:(NSString *)stationPhone;

@end
