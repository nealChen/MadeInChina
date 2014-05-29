//
//  JXTIIUserModel.m
//  JiaXingTrafficII
//
//  Created by mac on 13-10-10.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIUserModel.h"

@implementation JXTIIUserModel

- (void)dealloc
{
    self.image = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
