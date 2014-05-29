//
//  JXTIIWalkMapViewController.m
//  JiaXingTrafficII
//
//  Created by mac on 13-10-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICWalkMapViewController.h"
#import "RouteAnnotation.h"
#import "UIImage+InternalMethod.h"

#define ALERT_NACIGATION_AGAIN_TAG 64 //再次尝试Tag

@interface MICWalkMapViewController ()<BMKSearchDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>

@property (MIC_STRONG,nonatomic) BMKSearch *search;

@property (MIC_STRONG,nonatomic) NSMutableArray *mi_routeInfo;

@end

@implementation MICWalkMapViewController
@synthesize mi_routeInfo;

- (void)dealloc {
    self.search.delegate = nil;
    self.mapView.delegate = nil;
    self.search = nil;
    
    self.mi_routeInfo = nil;
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
	
    if (0 == self.title.length) {
        self.title = @"步行导航";
    }
    
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    self.mapView.delegate =self;
    
//    [self tileForMap];
    [self.view addSubview:self.mapView];
    [self.mapView setFrame:self.mapView.bounds];
//    NSLog(@"--%f",self.mapView.frame.origin.y);
    
    self.mi_routeInfo = [NSMutableArray array];
    
     [self startWalkNavigation:self];
    //添加对地图的手势代理
    // 单击的 Recognizer
//    UITapGestureRecognizer* singleRecognizer;
//    singleRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)] autorelease];
//    //点击的次数
//    singleRecognizer.numberOfTapsRequired = 1; // 单击
//    //给self.view添加一个手势监测；
//    [self.mapView addGestureRecognizer:singleRecognizer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView removeOverlays:[NSArray arrayWithArray:self.mapView.overlays]];
    [self.mapView removeAnnotations:[NSArray arrayWithArray:self.mapView.annotations]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidUnload {
//    [self setScrollMap:nil];
//    [self setMi_tableView:nil];
//    [super viewDidUnload];
//}

//ViewDeck手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if ([[[touch.view superview]superview] class] == [BMKMapView class]) {
        return NO;
    }

    NSLog(@"%@",gestureRecognizer);
    return YES;
}

//开始步行导航
-(void)startWalkNavigation:(id)sender{
    
    [self.mapView removeAnnotations:[NSArray arrayWithArray:self.mapView.annotations]];
	[self.mapView removeOverlays:[NSArray arrayWithArray:self.mapView.overlays]];
    
    //设置地图中心点
//    if (self.startPlanNode.pt.latitude <=0 || self.startPlanNode.pt.longitude <=0) {
//        [self.mapView setCenterCoordinate:self.currentLocation.coordinate animated:YES];
//        self.mapView.zoomLevel = 15;
//    }else{
//        [self.mapView setCenterCoordinate:self.startPlanNode.pt animated:YES];
//    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showWaitingToHUD];
    });
    
	BOOL flag = [_search walkingSearch:CITY startNode:self.startPlanNode endCity:CITY endNode:self.endPlanNode];
	if (!flag) {
		NSLog(@"search failed");
//        [self showMessageBox:@"提示" Message:@"导航失败！"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeHUD];
        });

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Nil message:@"导航失败,再次尝试？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = ALERT_NACIGATION_AGAIN_TAG;
        [alert show];
	}
    
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (ALERT_NACIGATION_AGAIN_TAG == [alertView tag]) {
        if (1 == buttonIndex) {
            [self startWalkNavigation:alertView];
        }
    }
}

#pragma mark 导航线路绘制
//map画线的相关代理
- (NSString*)getMyBundlePath1:(NSString *)filename
{
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		NSLog ( @"%@" ,s);
		return s;
	}
	return nil ;
}

- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
		default:
			break;
	}
	
	return view;
}
- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeHUD];
    });
    
    NSLog(@"%@",result);
    [mi_routeInfo removeAllObjects];
    NSLog(@"onGetWalkingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
		RouteAnnotation* item = MIC_AUTORELEASE([[RouteAnnotation alloc]init]);
		item.coordinate = result.startNode.pt;
		item.title = @"起点";
        [mi_routeInfo addObject:item.title];
		item.type = 0;
		[self.mapView addAnnotation:item];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
        
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = MIC_AUTORELEASE([[RouteAnnotation alloc]init]);
				item.coordinate = step.pt;
				item.title = step.content;
                [mi_routeInfo addObject:item.title];
				item.degree = step.degree * 30;
				item.type = 4;
				[self.mapView addAnnotation:item];
			}
			
		}
        [mi_routeInfo removeLastObject];
		item = MIC_AUTORELEASE([[RouteAnnotation alloc]init]);
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = @"终点";
		[self.mapView addAnnotation:item];

		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[self.mapView addOverlay:polyLine];
		delete []points;
        int distance=((BMKRoute*)[plan.routes objectAtIndex:0]).distance;
        NSString *tempString=[NSString stringWithFormat:@"全程:%d米",distance];
        [mi_routeInfo addObject:tempString];
//        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
        NSLog(@"导航绘制完成");
        [self autoZoom];
        
	}
    else
    {
        if ([self.view window]==nil) {
            return;
        }
        [self showMessageBox:@"提示" Message:@"未找到路线"];
    }
    
}
//-(void)reloadTableView
//{
//    [self.mi_tableView reloadData];
//    //    CGRect rect=self.mi_tableView.frame;
//    //    CGSize tempSize=self.mi_tableView.contentSize;
//    //    rect.size=tempSize;
//    //    self.mi_tableView.frame=rect;
//}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = MIC_AUTORELEASE([[BMKPolylineView alloc] initWithOverlay:overlay]);
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
	return nil;
}

@end
