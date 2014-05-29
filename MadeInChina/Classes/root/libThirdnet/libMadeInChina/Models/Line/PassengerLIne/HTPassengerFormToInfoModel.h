//
//  HTPassengerFormToInfoModel.h
//  HzTraffic
//
//  Created by sanwangkeji on 14-2-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface HTPassengerFormToInfoModel : MICSQLBaseObject

/**
 *起点
 */
@property (nonatomic, strong) NSString *startName;
/**
 * 终点
 */
@property (nonatomic, strong)  NSString *endName;
/**
 * 日期
 */
@property (nonatomic, strong)  NSString *time;

@end
