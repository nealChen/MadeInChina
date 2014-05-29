//
//  JXTIITransferStepLineDetails.h
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIITransferStepLineDetails : MICSQLBaseObject

@property (assign,nonatomic)int lineId;

///0～环线 1～上行 2～下行  服务端: 1~ 上行 or 环线  2~下行
@property (assign,nonatomic)int type;

@property (copy,nonatomic)NSString *name;
///线路类型
@property (copy,nonatomic)NSString *lineType;
///线路开始时间
@property (copy,nonatomic)NSString *startTime;
///吸纳路结束时间
@property (copy,nonatomic)NSString *endTime;
///票价
@property (assign,nonatomic)double price;
///站点数
@property (assign,nonatomic)int stationCount;
///距离
@property (assign,nonatomic)int distance;


@end
