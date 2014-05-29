//
//  JXTIIWalkMapViewController.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICSimpleMapViewController.h"

/*!
 步行导航
 */
@interface MICWalkMapViewController : MICSimpleMapViewController

/*!
 起点
 */
@property (nonatomic,strong)BMKPlanNode *startPlanNode;
/*!
 终点
 */
@property (nonatomic,strong)BMKPlanNode *endPlanNode;

@end
