//
//  MICMapViewController.m
//  MadeInChina
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICMapViewController.h"
#import "UtilsMacro.h"

//static BMKUserLocation *_currentUserLocation;

@interface MICMapViewController ()

@end

@implementation MICMapViewController
@synthesize mapHelper;

- (void)dealloc
{
    self.mapView.delegate = nil;
    self.mapView = nil;
    self.mapHelper = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapHelper = [MICBaiduMapHelper sharedMapHelper];
    
    _mapView =MIC_RETAIN([mapHelper mapView]);
    
    CGSize size = [self viewOfWindowSize];

    [_mapView setFrame:CGRectMake(0, 0, size.width, size.height)];
    
    _mapView .showsUserLocation = NO;//先关闭显示的定位图层
    
    _mapView .userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    
    _mapView .showsUserLocation = YES;//显示定位图层
    
//    _search = [mapHelper search];
    
//    [mapHelper setSearch_delegate:self];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [_mapView viewWillAppear];
    [_mapView setShowsUserLocation:YES];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
//    [mapHelper setSearch_delegate:self];
    [super viewDidAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
//    [mapHelper setSearch_delegate:nil];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    [_mapView setShowsUserLocation:NO];
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tileForMap{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView commitAnimations];
    [self.view addSubview:self.mapView];
}
-(void)tileMapToView:(UIView*)view{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:view cache:YES];
    [UIView commitAnimations];
    [view addSubview:self.mapView];
}
-(void)furlForMap{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:[self.mapView superview] cache:YES];
    [UIView commitAnimations];
    [self.mapView removeFromSuperview];
}


-(MICLocation *)currentLocation{
    return [[MICBaiduMapHelper sharedMapHelper] currentLocation];
}

-(void)autoZoom{
    
    NSMutableArray *array_latitude =[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *array_longitude = [[NSMutableArray alloc]initWithCapacity:0];
    for (id<BMKAnnotation> annotation in [NSArray arrayWithArray:self.mapView.annotations]) {
        NSNumber *t_latitude = [NSNumber numberWithDouble:[annotation coordinate].latitude];
        NSNumber *t_longitude = [NSNumber numberWithDouble:[annotation coordinate].longitude];
        
        [array_latitude addObject:t_latitude];
        [array_longitude addObject:t_longitude];
    }
    

    
    //设置最佳视角
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    NSArray *arr1 = [array_latitude sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    double lat=[[arr1 objectAtIndex:0] doubleValue]+[[arr1 lastObject] doubleValue];
    NSArray *arr2 = [array_longitude sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    double lon=[[arr2 objectAtIndex:0] doubleValue]+[[arr2 lastObject] doubleValue];
    CLLocationCoordinate2D location2d=CLLocationCoordinate2DMake(lat/2, lon/2);
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(location2d,BMKCoordinateSpanMake([[arr1 lastObject] doubleValue]-[[arr1 objectAtIndex:0] doubleValue],
                                                                                              [[arr2 lastObject] doubleValue]-[[arr2 objectAtIndex:0] doubleValue]));
//    [_mapView setRegion:viewRegion];
    [_mapView setRegion:viewRegion animated:YES];
    
    MIC_RELEASE(array_latitude);
    MIC_RELEASE(array_longitude);
    
}

#pragma mark - BMKMapViewDelegate
/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{

}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    return nil;
}

/**
 *当mapView新添加annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 新添加的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views{}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{

}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{

}

/**
 *拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
 *@param mapView 地图View
 *@param view annotation view
 *@param newState 新状态
 *@param oldState 旧状态
 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState{

}

/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    return nil;
}

/**
 *当mapView新添加overlay views时，调用此接口
 *@param mapView 地图View
 *@param overlayViews 新添加的overlay views
 */
- (void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews{

}

/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi{

}

/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{

}

/**
 *双击地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回双击处坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate{

}

/**
 *长按地图时会回调此接口
 *@param mapview 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate{

}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
/* v2.1.0之后废除
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView{
    NSLog(@"开始定位");
}
 */

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
/* v2.1.0之后废除
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView{
    NSLog(@"关闭定位");
}
 */

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
/* v2.1.0之后废除
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    if (userLocation) {
        BMKUserLocation *_currentUserLocation = self.currentLocation;
        
        if (!_currentUserLocation|| ![_currentUserLocation.location isEqual:userLocation.location] || _currentUserLocation.updating != userLocation.updating ) {

            NSString *old_title = [_currentUserLocation title];
            NSString *old_subtitle = [_currentUserLocation subtitle];
            self.currentLocation = userLocation;
            NSLog(@"当前位置改变");
            NSLog(@"当前的坐标是: %f,%f",self.currentLocation.location.coordinate.latitude,self.currentLocation.location.coordinate.longitude);
            

            if (old_title) {
                self.currentLocation.title = old_title ;
            }

            if (old_subtitle) {
                self.currentLocation.subtitle = old_subtitle;
            }
            
        }
        
    }
}
 */

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
/* v2.1.0之后废除
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTosat:@"定位失败"];
    });
}
*/

#pragma mark BMKSearchDelegate (空实现)
/**
 *返回POI搜索结果
 *@param poiResultList 搜索结果列表，成员类型为BMKPoiResult
 *@param type 返回结果类型： BMKTypePoiList,BMKTypeAreaPoiList,BMKAreaMultiPoiList
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error{}

/**
 *返回公交搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetTransitRouteResult:(BMKPlanResult*)result errorCode:(int)error{}

/**
 *返回驾乘搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error{}

/**
 *返回步行搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error{}

/**
 *返回地址信息搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error{}
/**
 *返回suggestion搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetSuggestionResult:(BMKSuggestionResult*)result errorCode:(int)error{}

/**
 *返回busdetail搜索结果
 *@param busLineResult 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetBusDetailResult:(BMKBusLineResult*)busLineResult errorCode:(int)error{}

/**
 *返回poi详情分享url
 *@param url 返回结果url
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetShareUrl:(NSString*) url withType:(BMK_SHARE_URL_TYPE) urlType errorCode:(int)error{}


@end
