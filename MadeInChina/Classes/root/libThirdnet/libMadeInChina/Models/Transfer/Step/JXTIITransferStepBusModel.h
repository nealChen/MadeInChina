//
//  JXTIITransferStepBusModel.h
//  HzTraffic
//
//  Created by mac on 14-2-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "JXTIITransferStepModel.h"
#import "JXTIITransferStepLineDetails.h"
#import "JXTIITransferStepLineTrails.h"

@interface JXTIITransferStepBusModel : JXTIITransferStepModel

//线路详情
@property (strong,nonatomic)JXTIITransferStepLineDetails *lineDetails;
//线路轨迹 JXTIITransferStepLineTrails
@property (strong,nonatomic)NSArray *lineTrails;


@end
