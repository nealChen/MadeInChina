//
//  HTSimpleMapViewController.m
//  HzTraffic
//
//  Created by mac on 14-2-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSimpleMapViewController.h"
#import "NSString+MadeInChina.h"
#import "MICBaiduMapHelper.h"

@interface MICSimpleMapViewController ()

@property (MIC_WEAK,nonatomic)MICBaiduMapHelper *mapHelper;

@end

@implementation MICSimpleMapViewController
@synthesize mapHelper;
@synthesize mapView;

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
	
    //默认重用标志
    if (!self.reuseIdentifier) {
        self.reuseIdentifier = [NSString stringWithUUID];
    }
    
    mapHelper = [MICBaiduMapHelper sharedMapHelper];
    
    if (!mapView) {
        mapView = mapHelper.mapView;
    }
    [self.mapView setFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view insertSubview:self.mapView atIndex:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [mapHelper recoverMapConditionWithKey:self.reuseIdentifier];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
    [mapHelper coverMapConditionWithKey:self.reuseIdentifier];
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    self.reuseIdentifier = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}


-(void)autoZoom{
    
    if (self.mapView.annotations.count == 0) {
        return;
    }
    
    NSMutableArray *array_latitude =[NSMutableArray array];
    NSMutableArray *array_longitude = [NSMutableArray array];
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
    [self.mapView setRegion:viewRegion animated:YES];

}

-(void)refreshMap{
    
    [self.mapView setZoomLevel:self.mapView.zoomLevel - 0.0001];

}

@end
