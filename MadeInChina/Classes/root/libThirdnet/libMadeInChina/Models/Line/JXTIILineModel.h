//
//  JXTIILineModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-9-17.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICSQLBaseObject.h"

@interface JXTIILineModel : MICSQLBaseObject

@property (assign,nonatomic)int lineId;

///0～环线 1～上行 2～下行  服务端: 1~ 上行 or 环线  2~下行
@property (assign,nonatomic)int type;
///线路名称
@property (copy,nonatomic)NSString *name;
///起点编号
@property (assign,nonatomic)int startId;
///起点名称
@property (copy,nonatomic)NSString *startName;
///终点编号
@property (assign,nonatomic)int endId;
///终点名称
@property (copy,nonatomic)NSString *endName;


//+(instancetype)lineFormatWithDictionary:(NSDictionary *)aDic;
//
//-(id)initWithDictionary:(NSDictionary *)aDic;


@end
