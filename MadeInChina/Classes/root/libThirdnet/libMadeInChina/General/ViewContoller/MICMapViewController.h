//
//  MICMapViewController.h
//  MadeInChina
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/*!
 @header
 @abstract MICMapViewController.
 */

#import "MICViewController.h"
#import "MICBaiduMapHelper.h"

/*!
 @class
 @abstract MICMapViewController父类.
 @discussion 所有的MapViewController都应该继承该类.
 */
@interface MICMapViewController : MICViewController<BMKMapViewDelegate,BMKSearchDelegate>
/*!
 @property
 @abstract Baidu地图辅助对象.
 */
@property (nonatomic,MIC_WEAK) MICBaiduMapHelper *mapHelper;
/*!
 @property
 @abstract 地图视图.
 @discussion 该视图默认大小与view相同,请根据需要调整(单例).
 */
@property (nonatomic,MIC_STRONG) BMKMapView *mapView;
/*!
 @property
 @abstract 搜索对象,search.delegate 请勿改动，否则定位将失效.
 */
@property (nonatomic,readonly) BMKSearch *search;

/*!
 @property
 @abstract 当前的位置.
 @discussion 定位信息
 */
@property (nonatomic,readonly) MICLocation *currentLocation;

/*!
 展开地图
 */
-(void)tileForMap;
/*!
 展开地图到view
 */
-(void)tileMapToView:(UIView*)view;
/*!
 收拢地图
 */
-(void)furlForMap;
/*!
 智能调整展示区域
 */
-(void)autoZoom;

@end
