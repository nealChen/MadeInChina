//
//  MBaiduView.m
//  HzTraffic
//
//  Created by  mac on 12-10-24.
//
//

#import "MICBaiduMapHelper.h"
#import "NSString+MadeInChina.h"
#import "UtilsMacro.h"


CLLocationDistance MICLocationToLocationDistance(CLLocation *location1,CLLocation *location2){
    return MICCoordinateToCoordinateDistance(location1.coordinate, location2.coordinate);
}

CLLocationDistance MICCoordinateToCoordinateDistance(CLLocationCoordinate2D coor1,CLLocationCoordinate2D coor2){
    double distance ;
    //百度的方案
    BMKMapPoint point1_1 = BMKMapPointForCoordinate(coor1);
    BMKMapPoint point2_1 = BMKMapPointForCoordinate(coor2);
    distance = BMKMetersBetweenMapPoints(point1_1, point2_1);
//    NSLog(@"baidu distance: %f",distance);

    /*
     //gps方案
     CLLocation * location1 = [[CLLocation alloc]initWithLatitude:coor1.latitude longitude:coor1.longitude];
     CLLocation * location2 = [[CLLocation alloc]initWithLatitude:coor2.latitude longitude:coor2.longitude];
     distance = [location1 distanceFromLocation:location2];
//     NSLog(@"gps distance: %f",distance);
     */
    
    return distance;
}

BOOL MICCoordinateApproximatelyEqualToCoordinate(CLLocationCoordinate2D coor1,CLLocationCoordinate2D coor2,CLLocationAccuracy accuracy){

    double distance = MICCoordinateToCoordinateDistance(coor1, coor2);
    return distance < accuracy;

}

NSString * MICFormatTreeLayersAddressComponent(BMKGeocoderAddressComponent* addressComponent){
    
    if (!addressComponent) {
        return nil;
    }
    NSString *part[4] = {@"",@"",@"",@""};
    
    if (addressComponent.streetNumber.length > 0) {
        
        part[2] = addressComponent.streetNumber;
        part[1] = addressComponent.streetName;
        part[0] = addressComponent.district;
        
    }else if (addressComponent.streetName.length > 0){
        
        part[2] = addressComponent.streetName;
        part[1] = addressComponent.district;
        part[0] = addressComponent.city;
        
    }else if (addressComponent.district){
        
        part[2] = addressComponent.district;
        part[1] = addressComponent.city;
        part[0] = addressComponent.province;
        
    }else if (addressComponent.city){
        
        part[1] = addressComponent.city;
        part[0] = addressComponent.province;
        
    }else if (addressComponent.province){
        
        part[0] = addressComponent.province;
        
    }
    
    
    
    part[3] = [NSString stringWithFormat:@"%@%@%@",part[0],part[1],part[2]];
    
    return [NSString isEmpty:part[3]] ? nil : part[3];

}


static MICBaiduMapHelper * mapView_;

@interface MICBaiduMapHelper()<BMKUserLocationDelegate>

///地图状态集合
@property (MIC_STRONG,nonatomic)NSMutableDictionary *dic_map_condition;
//只是定位辅助对象，它并未真正实现BMKAnnotation
@property (MIC_STRONG,nonatomic) BMKUserLocation *userLocation;

@end

@implementation MICBaiduMapHelper
@synthesize mapView;
@synthesize currentLocation;
@synthesize userLocation;

- (id)init
{
    self = [super init];
    
    if (self) {
        currentLocation = [[MICLocation alloc]init];
        currentLocation.title = @"正在获取当前位置";
        self.dic_map_condition = [NSMutableDictionary dictionary];
        _locationAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self initLocation];
    }
    return self;
}


-(void)dealloc{
    //关闭定位服务
    [userLocation stopUserLocationService];
    userLocation.delegate = nil;
    self.userLocation = nil;
    MIC_RELEASE(currentLocation);
    self.dic_map_condition = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}
/*
 单例模式实现方法
 */
+ (instancetype)sharedMapHelper
{
    @synchronized(self)
    {
        if (!mapView_) {
            mapView_ = [[MICBaiduMapHelper alloc] init];
        }
        return mapView_ ;
    }
}
+(id) allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (mapView_ == nil)
        {
            mapView_ = [super allocWithZone:zone];
            return mapView_;
        }
    }
    return nil;
}

#pragma mark 定位管理
-(void)initLocation{
    userLocation = [[BMKUserLocation alloc]init];
    userLocation.delegate = self;
    //开启定位服务
    [userLocation startUserLocationService];
}

-(BMKMapView *)mapView{
//    return MIC_AUTORELEASE([[BMKMapView alloc]init]);
    
    static dispatch_once_t once;
    static BMKMapView * __singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[BMKMapView alloc] init]; } );
    return __singleton__; 
}

#pragma mark BMKUserLocationDelegate
/**
 *调用startUserLocationService定位成功后，会调用此函数
 *@param userLoc 我的位置坐标
 */
- (void)viewDidGetLocatingUser:(CLLocationCoordinate2D)userLoc{
    
    BOOL equal = MICCoordinateApproximatelyEqualToCoordinate(currentLocation.coordinate, userLoc, _locationAccuracy);
    
    if (equal) {
        return;
    }

    [currentLocation setCoordinate:userLoc];
    [[NSNotificationCenter defaultCenter]postNotificationName:MIC_CURRENT_LOCATION_CHANGED object:currentLocation];
    NSLog(@"当前位置更新 lon:%f lat:%f",userLoc.longitude,userLoc.latitude);


}


-(id)coverMapConditionWithKey:(id)aKey{
    
    NSMutableDictionary *dic_cover = [NSMutableDictionary dictionary];
    
    //存储标注
    NSArray *annotations = [NSArray arrayWithArray:self.mapView.annotations];
    if (annotations.count > 0) {
        [dic_cover setObject:annotations forKey:@"annotations"];
        [self.mapView removeAnnotations:annotations];
    }
    
    //存储覆盖物
    NSArray *overlays = [NSArray arrayWithArray:self.mapView.overlays];
    if (overlays.count > 0) {
        [dic_cover setObject:overlays forKey:@"overlays"];
        [self.mapView removeAnnotations:overlays];
    }
    
    //存储地图类型
    NSNumber *number_maptype = [NSNumber numberWithInteger:self.mapView.mapType];
    [dic_cover setObject:number_maptype forKey:@"mapType"];
    
    //存储视图范围
    BMKCoordinateRegion region = self.mapView.region;
    NSValue *value_region = [NSValue value:&region withObjCType:@encode(BMKCoordinateRegion)];
    [dic_cover setObject:value_region forKey:@"region"];
    
    //存储指南针的位置
    NSValue *value_compassPosition = [NSValue valueWithCGPoint:self.mapView.compassPosition];
    [dic_cover setObject:value_compassPosition forKey:@"compassPosition"];
    
    //存储中心点位置
    CLLocationCoordinate2D centerCoordinate = self.mapView.centerCoordinate;
    NSValue *value_centerCoordinate = [NSValue value:&centerCoordinate withObjCType:@encode(CLLocationCoordinate2D)];
    [dic_cover setObject:value_centerCoordinate forKey:@"centerCoordinate"];
    
    //存储是否显示地位层
    NSNumber *number_showUserLocation = [NSNumber numberWithBool:self.mapView.showsUserLocation];
    [dic_cover setObject:number_showUserLocation forKey:@"showsUserLocation"];
    
    //存储定位模式
    BMKUserTrackingMode userTrackingMode = self.mapView.userTrackingMode;
    NSValue *value_userTrackingMode = [NSValue value:&userTrackingMode withObjCType:@encode(BMKUserTrackingMode)];
    [dic_cover setObject:value_userTrackingMode forKey:@"userTrackingMode"];
    
    //存储是否显示比例尺
    NSNumber *number_showMapScaleBar = [NSNumber numberWithBool:self.mapView.showMapScaleBar];
    [dic_cover setObject:number_showMapScaleBar forKey:@"showMapScaleBar"];
    
    //存储比例尺的位置
    NSValue *value_mapScaleBarPosition = [NSValue valueWithCGPoint:self.mapView.mapScaleBarPosition];
    [dic_cover setObject:value_mapScaleBarPosition forKey:@"mapScaleBarPosition"];
    
    //存储当前地图范围
    BMKMapRect visibleMapRect = self.mapView.visibleMapRect;
    NSValue *value_visibleMapRect = [NSValue value:&visibleMapRect withObjCType:@encode(BMKMapRect)];
    [dic_cover setObject:value_visibleMapRect forKey:@"visibleMapRect"];
    
    //存储地图状态
    BMKMapStatus *mapStatus = self.mapView.getMapStatus;
    [dic_cover setObject:mapStatus forKey:@"mapStatus"];
    
    [self.dic_map_condition setObject:dic_cover forKey:aKey];

    return dic_cover;
}

-(id)recoverMapConditionWithKey:(id)aKey{
    
    NSDictionary *dic_re = [self.dic_map_condition objectForKey:aKey];
    if (dic_re && ![dic_re isEqual:[NSNull null]]) {
    
        //恢复

        //恢复标注
        NSArray *annotations = [dic_re objectForKey:@"annotations"];
        if (annotations.count > 0) {
            [self.mapView addAnnotations:annotations];
        }
        
        //恢复覆盖物
        NSArray *overlays = [dic_re objectForKey:@"overlays"];
        if (overlays.count > 0) {
            [self.mapView addOverlays:overlays];
        }
        
        //恢复地图类型
        NSNumber *number_maptype = [dic_re objectForKey:@"mapType"];
        [self.mapView setMapType:[number_maptype integerValue]];
        
        //恢复视图范围
        NSValue *value_region = [dic_re objectForKey:@"region"];
        BMKCoordinateRegion region;
        [value_region getValue:&region];
        [self.mapView setRegion:region];
        
        //恢复指南针的位置
        NSValue *value_compassPosition = [dic_re objectForKey:@"compassPosition"];
        CGPoint point_compassPosition ;
        [value_compassPosition getValue:&point_compassPosition];
        [self.mapView setCompassPosition:point_compassPosition];
        
        //恢复中心点位置
        NSValue *value_centerCoordinate = [dic_re objectForKey:@"centerCoordinate"];
        CLLocationCoordinate2D centerCoordinate;
        [value_centerCoordinate getValue:&centerCoordinate];
        [self.mapView setCenterCoordinate:centerCoordinate];
        
        //恢复是否显示地位层
        NSNumber *number_showUserLocation = [dic_re objectForKey:@"showsUserLocation"];
        [self.mapView setShowsUserLocation:[number_showUserLocation boolValue]];
        
        //恢复定位模式
        NSValue *value_userTrackingMode = [dic_re objectForKey:@"userTrackingMode"];
        BMKUserTrackingMode userTrackingMode;
        [value_userTrackingMode getValue:&userTrackingMode];
        [self.mapView setUserTrackingMode:userTrackingMode];
        
        //恢复是否显示比例尺
        NSNumber *number_showMapScaleBar = [dic_re objectForKey:@"showMapScaleBar"];
        [self.mapView setShowMapScaleBar:[number_showMapScaleBar boolValue]];
        
        //恢复比例尺的位置
        NSValue *value_mapScaleBarPosition = [dic_re objectForKey:@"mapScaleBarPosition"];
        CGPoint point_mapSecaleBarPosition;
        [value_mapScaleBarPosition getValue:&point_mapSecaleBarPosition];
        [self.mapView setMapScaleBarPosition:point_mapSecaleBarPosition];
        
        //恢复当前地图范围

        NSValue *value_visibleMapRect = [dic_re objectForKey:@"visibleMapRect"];
        BMKMapRect visibleMapRect;
        [value_visibleMapRect getValue:&visibleMapRect];
        [self.mapView setVisibleMapRect:visibleMapRect];
        
        //存储地图状态
        BMKMapStatus *mapStatus = [dic_re objectForKey:@"mapStatus"];
        [self.mapView setMapStatus:mapStatus];
    }else{
        //第一次加载
//        [self.mapView setCenterCoordinate:self.currentLocation.coordinate animated:YES];
    }
    
    return dic_re;
}

@end



///// 地图比例尺级别，在手机上当前可使用的级别为3-19级
//@property (nonatomic) float zoomLevel;
//
///// 地图旋转角度，在手机上当前可使用的范围为－180～180度
//@property (nonatomic) int rotation;
//
///// 地图俯视角度，在手机上当前可使用的范围为－45～0度
//@property (nonatomic) int overlooking;

/**
 * 获取地图状态
 *@return 返回地图状态信息
 */
//- (BMKMapStatus*)getMapStatus;

/////缩放级别:[3~19]
//@property (nonatomic, assign) float fLevel;
/////旋转角度
//@property (nonatomic, assign) float fRotation;
/////俯视角度:[-45~0]
//@property (nonatomic, assign) float fOverlooking;
/////屏幕中心点坐标:在屏幕内，超过无效
//@property (nonatomic) CGPoint targetScreenPt;
/////地理中心点坐标:经纬度
//@property (nonatomic) CLLocationCoordinate2D targetG

/**
 *	设置地图状态
 *	@param	[in]	mapStatus	地图状态信息
 */
//- (void)setMapStatus:(BMKMapStatus*)mapStatus;



