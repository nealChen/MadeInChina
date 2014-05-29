//
//  MICLocation.h
//  BusMapII
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMKAnnotation.h"

/*!
 MIC的位置类
 */
@interface MICLocation : NSObject <BMKAnnotation>

//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
//
/// 要显示的标题
@property (copy) NSString *title;
/// 要显示的副标题
@property (copy) NSString *subtitle;
///gps坐标
@property (strong,nonatomic)CLLocation *gpsLocation;

@end
