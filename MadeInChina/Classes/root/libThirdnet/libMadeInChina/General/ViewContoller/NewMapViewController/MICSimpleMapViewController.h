//
//  HTSimpleMapViewController.h
//  HzTraffic
//
//  Created by mac on 14-2-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICViewController.h"
#import "BMapKit.h"
///简单的地图
@interface MICSimpleMapViewController : MICViewController<BMKMapViewDelegate>

/*!
 @property
 @abstract 地图视图.
 @discussion 该视图默认大小与view相同,请根据需要调整(单例).
 */
@property (nonatomic,readonly) BMKMapView *mapView;

///复用标志(请勿随意改变)
@property (nonatomic, copy) NSString *reuseIdentifier;

/*!
 智能调整展示区域
 */
-(void)autoZoom;
/*!
 刷新地图
 */
-(void)refreshMap;
@end
