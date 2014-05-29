//
//  JXTIILineModel.m
//  JiaXingTrafficII
//
//  Created by mac on 13-9-17.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIILineModel.h"

@implementation JXTIILineModel

//+(instancetype)lineFormatWithDictionary:(NSDictionary *)aDic{
//    return [[[self alloc] initWithDictionary:aDic]autorelease];
//}
//
//-(id)initWithDictionary:(NSDictionary *)aDic{
//    
//    
//    
//}

-(void)dealloc{
    self.name = nil;
    self.startName = nil;
    self.endName = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
