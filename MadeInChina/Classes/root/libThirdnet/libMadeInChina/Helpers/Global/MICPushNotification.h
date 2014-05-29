//
//  NSPushNotification.h
//  MadeInChina
//
//  Created by mac on 13-9-10.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/*!
 @header
 @abstract 推送功能.
 */

#import <Foundation/Foundation.h>

/*!
 @class
 @abstract 该类提供了推送功能.
 @discussion 这里的推送功能必须于AppDelegate结合使用
 */
@interface MICPushNotification : NSObject

/*!
 @method
 @abstract 获取通知状态.
 @discussion
 @result
 返回是否开启通知.
 */
-(BOOL)pushStatus;

/*!
 @method
 @abstract 获取通知状态.
 @result
 返回通知通知状态.
 */
-(UIRemoteNotificationType)pushStatusType;

/*!
 @method
 @abstract 通知订阅.
 */
-(void)subscriptionNotifcation;

/*!
 @method
 @abstract 通知退订.
 */
-(void)unsubscribeNotifcation;

/*!
 @method
 @abstract 通知退订.
 @param finishBlock
 当取消操作完成后执行的Block[参数是(NSData＊)Token].
 */
-(void)unsubscribeNotifcationFinishWithBlock:(void (^)(NSData* token))finishBlock;

/*!
 @method
 @abstract 通知退订.
 @param finishBlock
 当取消操作完成后执行的Block[参数是(NSString＊)Token].
 */
-(void)unsubscribeNotifcationFinishWithBlockAndStringToken:(void (^)(NSString* token))finishBlock;
@end
