//
//  ProjectMacro.h
//  MadeInChina
//
//  Created by sanwangkeji on 13-11-19.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#ifndef MadeInChina_ProjectMacro_h
#define MadeInChina_ProjectMacro_h

//字符串
#define NSStringFromInt(intValue)       [NSString stringWithFormat:@"%d",intValue]
#define NSStringFromDouble(doubleValue) [NSString stringWithFormat:@"%2f",doubleValue]
#define NSStringFromFloat(floatValue)   [NSString stringWithFormat:@"%f",floatValue]

//
#define ImageNamed(NSString)   [UIImage imageNamed:NSString]


//打印信息控制
//#ifdef DEBUG
//#else
//#define NSLog(...){};
//#endif

#undef NSLog
#define	NSLog	MICLog

//bug版本下测试用NSLog
#ifdef DEBUG

#define LOG(obj)           NSLog(@"%@",obj)
#define LOGFloat(f)           NSLog(@"%f",f)
#define LOGPoint(p)             NSLog(@"%f,%f", p.x, p.y)
#define LOGSize(p)              NSLog(@"%f,%f", p.width, p.height)
#define LOGRect(p)              NSLog(@"%f,%f,%f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height)

#else

#define LOG(obj)
#define LOGFloat(f)
#define LOGPoint(p)
#define LOGSize(p)
#define LOGRect(p)

#endif

//初始经纬度
#define  INIT_CLLOCATIONCOORDINATE  CLLocationCoordinate2DMake(-1000 , -1000)

//列表字体大小
#define CELL_FONTSIZE           16
#define CELL_FONT(s)            [UIFont systemFontOfSize:s]
#define CELL_DEFAULT_FONT       [UIFont systemFontOfSize:CELL_FONTSIZE]

#define  USER_DEFAULT           [NSUserDefaults standardUserDefaults]


///自定义格式化的宏
#undef	Format_Bikestation
#define Format_Bikestation(__rawLineArray ) \
-(NSMutableArray*)formatJXTIIBikeModel:(NSArray*)rawLineArray{\
NSMutableArray *t_arrayBike = [NSMutableArray array];\
for (NSDictionary *dic in rawLineArray){\
JXTIINearbyBikeStationModel *t_nearbyBike = [[[JXTIINearbyBikeStationModel alloc] init]autorelease];\
t_nearbyBike.areaName = [dic objectForKey:@"AreaName"];\
t_nearbyBike.count = [[dic objectForKey:@"Count"]intValue];\
t_nearbyBike.stationId = [[dic objectForKey:@"Id"] intValue];\
t_nearbyBike.name = [dic objectForKey:@"Name"];\
t_nearbyBike.longitude = [[dic objectForKey:@"Longitude"] doubleValue];\
t_nearbyBike.latitude = [[dic objectForKey:@"Latitude"] doubleValue];\
t_nearbyBike.address = [dic objectForKey:@"Address"];\
t_nearbyBike.distance = [[dic objectForKey:@"Distance"] intValue];\
t_nearbyBike.serviceTime = [dic objectForKey:@"ServiceTime"];\
t_nearbyBike.stationPhone = [dic objectForKey:@"StationPhone"];\
[t_arrayBike addObject:t_nearbyBike];\
}\
return t_arrayBike;\
}

///添加导航栏右边按钮
#undef	Add_NavigationBar
#define Add_NavigationBar(__imageName) \
-(void)addNavigationBar:(NSString *)imageName{\
    UIImage *ima=[UIImage imageNamed:imageName];\
    UIButton *showMapBtn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 5, 30, 30)]autorelease];\
    [showMapBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0f]];\
    [showMapBtn setImage:ima forState:UIControlStateNormal];\
    [showMapBtn setContentMode:UIViewContentModeScaleAspectFit];\
    [showMapBtn addTarget:self action:@selector(ClickRightBarBtn) forControlEvents:UIControlEventTouchUpInside];\
    UIBarButtonItem *BarBtn = [[[UIBarButtonItem alloc] initWithCustomView:showMapBtn]autorelease];\
    [self.navigationItem setRightBarButtonItem:BarBtn];\
}

#endif
