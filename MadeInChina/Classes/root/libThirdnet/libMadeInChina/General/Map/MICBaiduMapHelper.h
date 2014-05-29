//
//  MBaiduView.h
//  HzTraffic
//
//  Created by  mac on 12-10-24.
//
//

#import <Foundation/Foundation.h>
#import "MICLocation.h"
#import "BMapKit.h"

#ifndef MadeInChina_MICBaiduMapHelper_h
#define MadeInChina_MICBaiduMapHelper_h

/*!
 定位精度
 与以下保持一致
 kCLLocationAccuracyBestForNavigation
 kCLLocationAccuracyBest
 kCLLocationAccuracyNearestTenMeters
 kCLLocationAccuracyHundredMeters
 kCLLocationAccuracyKilometer
 kCLLocationAccuracyThreeKilometers
 */
//const CLLocationAccuracy kMICLocationAccuracyBestForNavigation =    -2.000000;
//const CLLocationAccuracy kMICLocationAccuracyBest =                 -1.000000;
//const CLLocationAccuracy kMICLocationAccuracyNearestTenMeters =     10.000000;
//const CLLocationAccuracy kMICLocationAccuracyHundredMeters =        100.000000;
//const CLLocationAccuracy kMICLocationAccuracyKilometer =            1000.000000;
//const CLLocationAccuracy kMICLocationAccuracyThreeKilometers =      3000.000000;

///当前位置发生改变
#define MIC_CURRENT_LOCATION_CHANGED @"MIC_CURRENT_LOCATION_CHANGED"

/*!
 一个点到另一个点的距离
 */
CLLocationDistance MICLocationToLocationDistance(CLLocation *location1,CLLocation *location2);
/*!
 一个坐标到另一个坐标的距离
 */
CLLocationDistance MICCoordinateToCoordinateDistance(CLLocationCoordinate2D coor1,CLLocationCoordinate2D coor2);
/*!
 一个坐标约等于另一个坐标
 accuracy表示精度
 */
BOOL MICCoordinateApproximatelyEqualToCoordinate(CLLocationCoordinate2D coor1,CLLocationCoordinate2D coor2,CLLocationAccuracy accuracy);

/*!
 格式化地址(三层)
 */
NSString * MICFormatTreeLayersAddressComponent(BMKGeocoderAddressComponent* addressComponent);

#endif


@interface MICBaiduMapHelper : NSObject

///地图(单例)
@property (readonly, nonatomic) BMKMapView * mapView;

///恢复地图状态
-(id)recoverMapConditionWithKey:(id)aKey;
///挂起地图状态
-(id)coverMapConditionWithKey:(id)aKey;

/*!
 当前位置
 */
@property (readonly, nonatomic) MICLocation *currentLocation;
/*!
 定位精度 默认 kCLLocationAccuracyNearestTenMeters
 */
@property (assign, nonatomic) CLLocationAccuracy locationAccuracy;

/*!
 搜索对象，请勿使用delegate属性
 */
//@property (readonly, nonatomic) BMKSearch *search;

/*!
 search的代理
 */
//@property (MIC_STRONG, nonatomic) id<BMKSearchDelegate> search_delegate;

/*!
 获取获取实例对象
 */
+ (instancetype)sharedMapHelper;

@end
