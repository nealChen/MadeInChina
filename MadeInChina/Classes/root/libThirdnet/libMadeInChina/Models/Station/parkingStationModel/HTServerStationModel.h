//
//  HTServerStationModel.h
//  HzTraffic
//
//  Created by sanwangkeji on 14-2-26.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIStationModel.h"

@interface HTServerStationModel : JXTIIStationModel

///详情
@property (copy,nonatomic)NSString *details;

///备注
@property (copy,nonatomic)NSString *remark;

///服务
@property (assign,nonatomic)int serviceType;

///距离
@property (assign,nonatomic)int distance;

@end
