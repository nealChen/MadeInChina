//
//  JXTIITransferStepLineTrails.h
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIITransferStepLineTrails : MICSQLBaseObject

///线路编号
@property (assign,nonatomic)int lineId;
///0～环线 1～上行 2～下行  服务端: 1~ 上行 or 环线  2~下行
@property (assign,nonatomic)int type;
///经度
@property (assign,nonatomic)double longitude;
///纬度
@property (assign,nonatomic)double latitude;
///轨迹序号
@property (assign,nonatomic)int trailsIndex;

@end


@interface JXTIITransferStepLineTrails (Strong)

-(void)setLongitudeByString:(NSString*)strLongitude;

-(void)setLatitudeByString:(NSString*)strLatitude;

@end