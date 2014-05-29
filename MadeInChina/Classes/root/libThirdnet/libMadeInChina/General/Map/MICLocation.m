//
//  MICLocation.m
//  BusMapII
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICLocation.h"

@interface MICLocation(){
    CLLocationCoordinate2D _coor2D;
}

@end

@implementation MICLocation

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coor2D = newCoordinate;
}

-(CLLocationCoordinate2D)coordinate{

    return _coor2D;
}

@end
