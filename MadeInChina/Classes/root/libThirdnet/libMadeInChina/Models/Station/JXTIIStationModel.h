//
//  JXTIIStationModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-9-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICSQLBaseObject.h"

@interface JXTIIStationModel : MICSQLBaseObject

///编号
@property (assign,nonatomic)int stationId;

///名称
@property (copy,nonatomic)NSString *name;

///别名
@property (copy,nonatomic)NSString *alias;

///经度
@property (assign,nonatomic)double longitude;

///纬度
@property (assign,nonatomic)double latitude;

///地址
@property (copy,nonatomic)NSString *address;

@end

@interface JXTIIStationModel (Strong)

-(void)setLongitudeByString:(NSString*)strLongitude;

-(void)setLatitudeByString:(NSString*)strLatitude;

@end
