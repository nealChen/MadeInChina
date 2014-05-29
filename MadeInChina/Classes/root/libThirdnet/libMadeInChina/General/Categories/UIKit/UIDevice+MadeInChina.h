//
//  UIDevice+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 设备信息
 */
NSString* DeviceInfo();


/**
 Provides extensions to `UIDevice` for various common tasks.
 */
@interface UIDevice (MadeInChina)
/**
 Returns `YES` if the device is a simulator.
 
 @return `YES` if the device is a simulator and `NO` if it is not.
 */
- (BOOL)isSimulator;

/**
 Returns `YES` if the device is an iPod touch, iPhone, iPhone 3G, or an iPhone 3GS.
 
 @return `YES` if the device is crappy and `NO` if it is not.
 */
- (BOOL)isCrappy;

@end
