//
//  MICAppDelegate.h
//  MadeInChina
//
//  Created by mac on 13-9-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

extern id UserInfo; //用户信息

@interface MICAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;


///登录
-(void)signIn:(NSNotification*)notification;
///登出
-(void)signOut:(NSNotification*)notification;
///推送
-(void)notification:(NSNotification*)notification;

@end
