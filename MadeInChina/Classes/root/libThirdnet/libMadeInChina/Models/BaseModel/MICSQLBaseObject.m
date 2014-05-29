//
//  JXTIISQLBaseObject.m
//  JiaXingTrafficII
//
//  Created by mac on 13-10-10.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICSQLBaseObject.h"

@implementation MICSQLBaseObject

- (void)dealloc
{
    for  (NSString *oneProp in [[self class] propertiesWithEncodedTypes])
        [self removeObserver:self forKeyPath:oneProp];

#if ! __has_feature(objc_arc)
    
    [[self class] unregisterObject:self];
    
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

@end
