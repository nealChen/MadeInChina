//
//  JXTIILocationAndLocation.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIILocationAndLocation : MICSQLBaseObject

@property (nonatomic,assign)int lalId;  //编号
@property (nonatomic,retain)NSString* name;   //搜索名称
@property (nonatomic,assign)double longitude;   //经度
@property (nonatomic,assign)double latitude;   //纬度
@property (nonatomic,retain)NSString* subName;   //搜索名称2
@property (nonatomic,assign)double subLongitude;   //经度2
@property (nonatomic,assign)double subLatitude;   //纬度2

@end
