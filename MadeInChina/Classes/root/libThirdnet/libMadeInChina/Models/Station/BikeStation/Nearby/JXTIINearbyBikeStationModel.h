//
//  JXTIINearbyBikeStationModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIBikeStationModel.h"

@interface JXTIINearbyBikeStationModel : JXTIIBikeStationModel
///距离
@property (assign, nonatomic)int distance;
///可借
@property (assign, nonatomic)int countParking;

@end

@interface JXTIINearbyBikeStationModel (Strong)

-(void)setDistanceOfStrong:(NSString*)strDistance;

@end