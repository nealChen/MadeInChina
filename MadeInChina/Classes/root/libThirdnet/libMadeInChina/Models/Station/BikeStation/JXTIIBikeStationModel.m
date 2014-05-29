//
//  JXTIIBikeStationModel.m
//  JiaXingTrafficII
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIBikeStationModel.h"

@implementation JXTIIBikeStationModel

-(void)setStationPhoneOfStrong:(NSString *)stationPhone{
    if (stationPhone && ![stationPhone isEqual:[NSNull null]] && ![stationPhone isEqualToString:@"NULL"] && ![stationPhone isEqual:@""]) {
        _stationPhone = [NSString stringWithFormat:@"%@",stationPhone];
    }else{
        _stationPhone = @"暂无服务电话";
    }
}

@end
