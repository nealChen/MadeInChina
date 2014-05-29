//
//  JXTIITrafficTransferDetailsModel.h
//  HzTraffic
//
//  Created by mac on 14-2-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@interface JXTIITrafficTransferDetailsModel : MICSQLBaseObject
///标题
@property (copy,nonatomic)NSString *title;
///距离
@property (assign,nonatomic)long distance;
///票价
@property (assign,nonatomic)double price;
///预计时间
@property (assign,nonatomic)long time;
///线路名列表
@property (MIC_STRONG,nonatomic)NSArray *arrayLineName;
///换乘步骤
@property (MIC_STRONG,nonatomic)NSArray *arrayStep;
///获取所有线路名
-(NSString *)allLineName;

@end
