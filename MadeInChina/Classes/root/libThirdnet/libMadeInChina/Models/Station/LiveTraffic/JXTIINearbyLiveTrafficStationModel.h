//
//  JXTIINearbyLiveTrafficStationModel.h
//  HzTraffic
//
//  Created by swkj001152 on 14-3-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIIStationModel.h"

@interface JXTIINearbyLiveTrafficStationModel : JXTIIStationModel
///链接地址
@property (copy,nonatomic)NSString *url;
///距离
@property (assign,nonatomic)int distance;
@end
