//
//  RouteAnnotation.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BMKPointAnnotation.h"
#import "BMapKit.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]


@interface RouteAnnotation : BMKPointAnnotation {
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;

@end
