//
//  JXTIITransferStepModel.h
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIITransferStepModel : MICSQLBaseObject

///经度
@property (assign,nonatomic)double longitude;

///纬度
@property (assign,nonatomic)double latitude;

///类型(0步行,1公交，2自行车,3地铁，4水上巴士)
@property (assign,nonatomic)int type;

///步行方向
@property (copy,nonatomic)NSString *direction;

///步行距离
@property (assign,nonatomic)int distance;

///时间

///到达站点编号
@property (assign,nonatomic)int stationId;

///到达站点名称
@property (copy,nonatomic)NSString *stationName;

///起点站点编号
@property (assign,nonatomic)int stationStartId;

///起点站点名称
@property (copy,nonatomic)NSString *stationStartName;

///起点站点经度
@property (assign,nonatomic)double stationStartLongitude;

///起点站点纬度
@property (assign,nonatomic)double stationStartLatitude;


@end


@interface JXTIITransferStepModel (Strong)

-(void)setLongitudeByString:(NSString*)strLongitude;

-(void)setLatitudeByString:(NSString*)strLatitude;

@end