//
//  HTMapForChoosingViewController.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICMapForChoosingViewController.h"
#import "MICBaiduMapHelper.h"

@interface MICMapForChoosingViewController ()

@end

@implementation MICMapForChoosingViewController

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
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{

    if (_moveToCurrentLocation) {
        
        MICLocation *location = [[MICBaiduMapHelper sharedMapHelper] currentLocation];
        if (location && CLLocationCoordinate2DIsValid(location.coordinate)) {
            [self.mapView setCenterCoordinate:location.coordinate animated:YES];
        }
   
    }
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate{
    
    BMKPointAnnotation *annotation = MIC_AUTORELEASE([[BMKPointAnnotation alloc]init]);
    annotation.title = @"地图选点";
    annotation.coordinate = coordinate;
    
    if ([self.mapChooseDelegate respondsToSelector:@selector(mapForChoosing:shouldAddAnnotation:)]) {

        if (![self.mapChooseDelegate mapForChoosing:self shouldAddAnnotation:annotation]) {
            
            return;;
            
        }
 
    }

    if (!self.allowsMultipleSelection) {
        //移除所有Annotation
        [self.mapView removeAnnotations:[NSArray arrayWithArray:self.mapView.annotations]];
        
    }
    
    [self.mapView addAnnotation:annotation];
    [self refreshMap];
    
    
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{

    if ([self.mapChooseDelegate respondsToSelector:@selector(mapForChoosing:viewForAnnotation:)]) {
        
        return [self.mapChooseDelegate mapForChoosing:self viewForAnnotation:annotation];
        
    }else{
    
        return nil;
        
    }
    
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{

    if ([self.mapChooseDelegate respondsToSelector:@selector(mapForChoosing:didSelectAnnotationView:)]) {
        [self.mapChooseDelegate mapForChoosing:self didSelectAnnotationView:view];
    }

}

@end
