//
//  HTPassengerTransportLineModel.h
//  HzTraffic
//
//  Created by sanwangkeji on 14-2-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIILineModel.h"

@interface HTPassengerTransportLineModel : JXTIILineModel
/**
 *车次
 * 车次是否存储到父类的id上?
 */
@property (nonatomic, assign) int number;
/**
 * 发车时间
 */
@property (nonatomic, strong) NSString *time;
/**
 * 余票数量
 */
@property (nonatomic, assign) int count;
/**
 * 票价
 */
@property (nonatomic, assign) double price;
/**
 * 发车日期
 */
@property (nonatomic, strong) NSString *date;
///**
// * 线路名
// */
//@property (nonatomic, strong) NSString *lineName;
/**
 * 车型
 */
@property (nonatomic, strong) NSString *vehicle;

/**
 * 预计行驶时间
 */
@property (nonatomic, strong) NSString *planTime;
/**
 * 距离
 */
@property(nonatomic,assign)int distance;
/**
 * 公司
 */
@property (nonatomic, strong) NSString *company;

@end
