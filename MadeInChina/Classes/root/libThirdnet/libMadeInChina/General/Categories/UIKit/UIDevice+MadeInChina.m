//
//  UIDevice+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UIDevice+MadeInChina.h"
#import "sys/utsname.h"

NSString* DeviceInfo(){
    
    NSString *deviceInfo = nil;
    
//    if (!deviceInfo) {
        //    UIDevice *dev = [UIDevice currentDevice];
        //
        //    NSString *deviceName = dev.localizedModel;
        //    NSString *deviceModel = dev.model;
        //    CLog(@"%@，%@\n%@",deviceName,deviceModel,dev.description);
        //here use sys/utsname.h
        struct utsname systemInfo;
        uname(&systemInfo);
        //get the device model and the system version
        NSString *platform=[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        NSLog(@"Device %@", platform);
        if ([platform isEqualToString:@"iPhone1,1"])    deviceInfo = @"iPhone1G GSM";
        if ([platform isEqualToString:@"iPhone1,2"])    deviceInfo = @"iPhone3G GSM";
        if ([platform isEqualToString:@"iPhone2,1"])    deviceInfo = @"iPhone3GS GSM";
        if ([platform isEqualToString:@"iPhone3,1"])    deviceInfo = @"iPhone4 GSM";
        if ([platform isEqualToString:@"iPhone3,3"])    deviceInfo = @"iPhone4 CDMA";
        if ([platform isEqualToString:@"iPhone4,1"])    deviceInfo = @"iPhone4S";
        if ([platform isEqualToString:@"iPhone5,1"])    deviceInfo = @"iPhone5";
        if ([platform isEqualToString:@"iPod1,1"])      deviceInfo = @"iPod 1G";
        if ([platform isEqualToString:@"iPod2,1"])      deviceInfo = @"iPod 2G";
        if ([platform isEqualToString:@"iPod3,1"])      deviceInfo = @"iPod 3G";
        if ([platform isEqualToString:@"iPod4,1"])      deviceInfo = @"iPod 4G";
        if ([platform isEqualToString:@"iPad1,1"])      deviceInfo = @"iPad WiFi";
        if ([platform isEqualToString:@"iPad2,1"])      deviceInfo = @"iPad2 WiFi";
        if ([platform isEqualToString:@"iPad2,2"])      deviceInfo = @"iPad2 GSM";
        if ([platform isEqualToString:@"iPad2,3"])      deviceInfo = @"iPad2 CDMAV";
        if ([platform isEqualToString:@"iPad2,4"])      deviceInfo = @"iPad2 CDMAS";
        if ([platform isEqualToString:@"i386"])         deviceInfo = @"Simulator";
        if ([platform isEqualToString:@"x86_64"])       deviceInfo = @"Simulator";
        deviceInfo = platform;
        
        //    　　iphone 5,1 　　iphone5(移动,联通)
        //    　　iphone 5,2 　　iphone5(移动,电信,联通)
        //    　　iphone 4,1 　   iphone4S
        //    　　iphone 3,1 　   iphone4(移动,联通)
        //    　　iphone 3,2  　  iphone4(联通)
        //    　　iphone 3,3 　   iphone4(电信)
        //    　　iphone 2,1       iphone3GS
        //    　　iphone 1,2 　   iphone3G
        //    　　iphone 1,1 　   iphone
        //    　　ipad 1,1 　　　 ipad 1
        //    　　ipad 2,1 　　　 ipad 2(Wifi)
        //    　　ipad 2,2 　　　 ipad 2(GSM)
        //    　　ipad 2,3 　　　 ipad 2(CDMA)
        //    　　ipad 2,4 　　　 ipad 2(32nm)
        //    　　ipad 2,5 　　　 ipad mini(Wifi)
        //    　　ipad 2,6 　　　 ipad mini(GSM)
        //    　　ipad 2,7 　　　 ipad mini(CDMA)
        //    　　ipad 3,1 　　　 ipad 3(Wifi)
        //    　　ipad 3,2 　　　 ipad 3(CDMA)
        //    　　ipad 3,3 　　　 ipad 3(4G)
        //    　　ipad 3,4　　　  ipad 4(Wifi)
        //    　　ipad 3,5　　　  ipad 4(4G)
        //    　　ipad 3,6　　　  ipad 4(CDMA)
        //    　　ipod 5,1　　　  ipod touch 5
        //    　　ipod 4,1　　　  ipod touch 4
        //    　　ipod 3,1 　　　 ipod touch 3
        //    　　ipod 2,1 　　　 ipod touch 2
        //    　　ipod 1,1 　　　 ipod touch

//    }
    
    return deviceInfo;
    
}

@implementation UIDevice (MadeInChina)

- (BOOL)isSimulator {
	static NSString *simulatorModel = @"iPhone Simulator";
	return [[self model] isEqualToString:simulatorModel];
}


- (BOOL)isCrappy {
	static NSString *iPodTouchModel = @"iPod touch";
	static NSString *iPhoneModel = @"iPhone";
	static NSString *iPhone3GModel = @"iPhone 3G";
	static NSString *iPhone3GSModel = @"iPhone 3GS";
	
	NSString *model = [self model];
	
	return ([model isEqualToString:iPodTouchModel] || [model isEqualToString:iPhoneModel] ||
			[model isEqualToString:iPhone3GModel] || [model isEqualToString:iPhone3GSModel]);
}

@end
