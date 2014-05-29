//
//  NSPushNotification.m
//  MadeInChina
//
//  Created by mac on 13-9-10.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICPushNotification.h"

@implementation MICPushNotification

-(BOOL)pushStatus{
    
    return [self pushStatusType] & UIRemoteNotificationTypeNone;
    
}

- (UIRemoteNotificationType)pushStatusType{
    
    return [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    
}

//通知订阅
-(void)subscriptionNotifcation{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    NSLog(@"通知开启");
    
}
//通知退订
-(void)unsubscribeNotifcation{
    
    [self unsubscribeNotifcationFinishWithBlock:^(NSData *token) {}];
    
}

//通知退订
-(void)unsubscribeNotifcationFinishWithBlock:(void (^)(NSData* token))finishBlock{

    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSData *token = [ud dataForKey:MIC_TOKEN_KEY];
    
    finishBlock(token);
    
    NSLog(@"通知关闭");
}

//通知退订
-(void)unsubscribeNotifcationFinishWithBlockAndStringToken:(void (^)(NSString* token))finishBlock{
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSData *token = [ud dataForKey:MIC_TOKEN_KEY];
    
    NSString *strToken = [[NSString alloc]initWithData:token encoding:MIC_STRING_ENCODING];
    
    finishBlock(strToken);
    
    NSLog(@"通知关闭");
}
@end
