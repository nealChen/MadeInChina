//
//  JXTIINearbyBikeStationModel.m
//  JiaXingTrafficII
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIINearbyBikeStationModel.h"

@implementation JXTIINearbyBikeStationModel

//父类中已经存在
//- (void)dealloc
//{
//    for  (NSString *oneProp in [[self class] propertiesWithEncodedTypes])
//        [self removeObserver:self forKeyPath:oneProp];
//    [[self class] unregisterObject:self];
//
//    [super dealloc];
//}


-(void)setDistanceOfStrong:(NSString *)strDistance{
    if (strDistance && ![strDistance isEqual:[NSNull null]]) {
        if (![strDistance isEqual:@"(null)"] && ![strDistance isEqual:@"<null>"]) {
            _distance = [strDistance intValue];
        }
    }
}

@end
