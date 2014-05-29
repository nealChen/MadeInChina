//
//  HTParkingModel.h
//  HzTraffic
//
//  Created by sanwangkeji on 14-2-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIStationModel.h"

@interface HTParkingModel : JXTIIStationModel

///类型
@property (copy,nonatomic)NSString *parkType;

///状态 1:"泊位已基本停满";2:"有极少量泊位可以停车";3: "有部分泊位可以停车";4:"还有较多泊位可以停车";
@property (assign,nonatomic)int state;

@end
