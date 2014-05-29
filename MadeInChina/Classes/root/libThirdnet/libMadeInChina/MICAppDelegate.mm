//
//  MICAppDelegate.m
//  MadeInChina
//
//  Created by mac on 13-9-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICAppDelegate.h"
#import "MICMapViewController.h"
#import "ThirdnetProvider.h"
#import "InstructionList.h"
#import "APService.h"
#import "BMapKit.h"

#define ALERT_VIEW_UPDATE_TAG 10021 //更新
#define NOTIFICATION_ALERT_TAG 44 //推送提示框Tag

//#import "MICCommand.h"
//#import "AppBoard_iPad.h"
//#import "AppBoard_iPhone1.h"
//#import "ExampleCommand.h"
BMKMapManager* _mapManager;


id UserInfo; //用户信息


@interface MICAppDelegate() <BMKGeneralDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>

///更新地址
@property (copy,nonatomic)NSString *updateUrl;
///推送列表
@property (MIC_STRONG,nonatomic)NSMutableArray *arrayNotification;

// 定位管理
@property (nonatomic, strong) CLLocationManager *locationManager;
// 判断程序是否在后台
@property (nonatomic, unsafe_unretained, getter=isExecutingInBackground) BOOL executingInBackground;

@end


@implementation MICAppDelegate

- (void)dealloc
{
    self.locationManager = nil;
    self.arrayNotification = nil;
    self.updateUrl = nil;
    self.navigationController = nil;
    self.window = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    MICCommandManager *commandManager = [MICCommandManager sharedCommandManager];
//    
//    
//    
//    [commandManager executeCommandProviderWithName:nil withObject:@"123" completeBlock:^int(id paramter) {
//        NSLog(@"%@",paramter);
//        return MIC_COMMAND_EXECUTE_SUCCESS;
//    }];
    self.arrayNotification = [NSMutableArray array];
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:BAIDU_API_KEY generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    //初始化配置
    MICConfig *config = [MICConfig sharedMICConfig];
    [config loadConfig];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(cheakUpdate:)
               name:MIC_INSTRUCTION_CHEAK_UPDATE object:nil];
    [nc addObserver:self selector:@selector(signIn:)
               name:MIC_INSTRUCTION_SIGN_IN object:nil];
    [nc addObserver:self selector:@selector(signOut:)
               name:MIC_INSTRUCTION_SIGN_OUT object:nil];
    [nc addObserver:self selector:@selector(registerForRemoteNotification:)
               name:MIC_INSTRUCTION_REGISTER_FOR_REMOTE_NOTIFICATION object:nil];
    [nc addObserver:self selector:@selector(unRegisterForRemoteNotification:)
               name:MIC_INSTRUCTION_UNREGISTER_FOR_REMOTE_NOTIFICATION object:nil];
    [nc addObserver:self selector:@selector(notification:)
               name:MIC_INSTRUCTION_PUSH_RECIVER object:nil];
    [nc addObserver:self selector:@selector(notification:)
               name:MIC_INSTRUCTION_LOADING object:nil];
    [nc addObserver:self selector:@selector(notification:)
               name:MIC_INSTRUCTION_LOADED object:nil];

    
    [nc postNotificationName:MIC_INSTRUCTION_LOADING object:nil];//加载
    
    //极光推送
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:)
                          name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:)
                          name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:)
                          name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:)
                          name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:)
                          name:kAPNetworkDidReceiveMessageNotification object:nil];
    
    // Required
    [APService setupWithOption:launchOptions];
    
    //    [APService setTags:[NSSet setWithObjects:@"tag1", @"tag2", @"tag3", nil] alias:@"别名"];
    [APService setTags:[NSSet setWithObjects:@"group",nil]
                 alias:@"defult"
      callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                object:self];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([ud boolForKey:MIC_TOKEN_KEY]) {
        if ([ud boolForKey:MIC_APPLICATION_NOTIFICATION_ENABLE_KEY]) {
            [defaultCenter
             postNotificationName:MIC_INSTRUCTION_REGISTER_FOR_REMOTE_NOTIFICATION
             object:nil];
        }
    }else{
        [defaultCenter
         postNotificationName:MIC_INSTRUCTION_REGISTER_FOR_REMOTE_NOTIFICATION
         object:nil];
    }
    
    
    
    
    // 定位管理
    self.locationManager = [[[CLLocationManager alloc] init]autorelease];// 初始化
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];// 设置精度值
    
    [self.locationManager setDelegate:self];// 设置代理
    
    [self.locationManager startUpdatingLocation];
    
    //    [self.locationManager startMonitoringSignificantLocationChanges];
    
    
    
    [MICBaiduMapHelper sharedMapHelper]; //启动地图引擎
    

//    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    
//    MICMapViewController *viewController = [[MICMapViewController alloc]init];
//    
////    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
////                         @"11",@"name"
////                         , nil];
////    NSError *error = nil;
////    
////   
////    MICNetwork *mm = [MICNetwork sharedMICNetwork];
////     NSDictionary *dic_result = [mm getInfoFromPort:@"QueryBusLine1" usedPortName:@"bus/line" withInputPara:dic error:&error];
////    if (!dic_result || error) {
////        if (error) {
////            NSLog(@"错误原因1：%@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
////            NSLog(@"错误原因2：%@",[dic_result objectForKey:@"Message"]);
////        }
////    }
//    navigationController=[[UINavigationController alloc]initWithRootViewController:viewController];
//    self.window.rootViewController = self.navigationController;
//    [self.window makeKeyAndVisible];
//    [viewController release];
    
     [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [application setApplicationIconBadgeNumber:0];
    
    // 当程序退到后台时，进行定位的重新计算
    
    self.executingInBackground = YES;
    
    //    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    
    // 程序进入前台，转化为高精确定位
    
    self.executingInBackground = NO;
    
    //    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //重置IconNumber
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

//错误处理
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog ( @ "Register Remote Notifications error:{%@}", [error localizedDescription ] );
}

//推送接受
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
    
    application.applicationIconBadgeNumber=0;
    NSLog ( @ "Receive remote notification : %@",userInfo );
    //以警告框的方式来显示推送消息
//    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
//        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"经过推送发送过来的消息"
//                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
//                                                       delegate:self
//                                              cancelButtonTitle:@"关闭"
//                                              otherButtonTitles:@"处理",nil] autorelease];
//        [alert show];
//
//    }
    
//    self.notifyViewController=
//    [[NotityViewController alloc]initWithNibName:@"NotityViewController" bundle:nil AndContent:userInfo];
//    self.notifyViewController.view.frame=[[UIScreen mainScreen] applicationFrame];
//    [self.window addSubview:self.notifyViewController.view];
//    [self.window makeKeyAndVisible];
}

#pragma mark BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
    NSLog(@"onGetNetworkState %d",iError);
}

- (void)onGetPermissionState:(int)iError
{
    NSLog(@"onGetPermissionState %d",iError);
}

#pragma mark JPush
- (void)networkDidSetup:(NSNotification *)notification {
    
    NSLog(@"JPush Connected！");
}

- (void)networkDidClose:(NSNotification *)notification {
    
    NSLog(@"JPush NotConnected!");
}

- (void)networkDidRegister:(NSNotification *)notification {
    
    NSLog(@"JPush Signed!");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"JPush Logined!");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    
    //    NSString *content = [userInfo valueForKey:@"content"];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    //    [_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    
    [self.arrayNotification addObject:userInfo];
    
    if ([[UIApplication sharedApplication]enabledRemoteNotificationTypes] != UIRemoteNotificationTypeNone) {
        UIAlertView *alert= [[UIAlertView alloc]
                            initWithTitle:@"提示"
                            message:@"收到一条新的通知！"
                            delegate:self
                            cancelButtonTitle:@"稍后再说"
                            otherButtonTitles:@"马上处理", nil];
        alert.tag=NOTIFICATION_ALERT_TAG;
        [alert show];
        [alert release];
    }
    NSLog(@"ApplicationNotificationTypers:%d",[[UIApplication sharedApplication]enabledRemoteNotificationTypes]);
    NSLog(@"JPush message:%@",userInfo);
    
    //    [dateFormatter release];
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

#pragma mark UIAlertViewDelgate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case ALERT_VIEW_UPDATE_TAG:
        {
            if (1 == buttonIndex) {
                
                if (0 == self.updateUrl.length) {
                    [[[[UIAlertView alloc]initWithTitle:@"更新失败" message:@"无法识别" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] autorelease] show];
                }else{
                    
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.updateUrl]];
                    exit(0);
                }
                
            }
        }
            break;
        case NOTIFICATION_ALERT_TAG://推送Alert
        {
            switch (buttonIndex) {
                case 1:
                {
                    //推送处理代码
                    [[NSNotificationCenter defaultCenter]postNotificationName:MIC_INSTRUCTION_PUSH_RECIVER object:[self.arrayNotification lastObject]];

                }
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - 判断是否在后台


// 判断是否在后台

- (BOOL) isExecutingInBackground{
    
    return _executingInBackground;
    
}


#pragma mark - CLLocationManagerDelegate


// 定位成功时，调用该方法-iOS 5 或者之前版本

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [self locationSuccess:newLocation];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self actionGetOffBy:newLocation];
//    });
//    
//    if ([self isExecutingInBackground]){
//        
//        // 在后台
//        NSLog(@"b%f",newLocation.coordinate.longitude);
//        
//    } else {
//        
//        // 在前台
//        NSLog(@"f%f",newLocation.coordinate.longitude);
//    }
    
}


// 定位成功时，调用该方法-iOS 6.0

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    
    CLLocation *newLocation = [locations lastObject];
    
    [self locationSuccess:newLocation];
//    if ([self isExecutingInBackground]){
//        
//        //        UIApplication *application = [UIApplication sharedApplication];
//        //        UIBackgroundTaskIdentifier __block bgTask;
//        //        bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
//        //            // Clean up any unfinished task business by marking where you.
//        //
//        //            // stopped or ending the task outright.
//        //            [application endBackgroundTask:bgTask];
//        //            bgTask = UIBackgroundTaskInvalid;
//        //        }];
//        
//        
//    } else {
//        
//        // 在前台
//        NSLog(@"f%f",newLocation.coordinate.longitude);
//        
//    }
    
}


- (void)locationSuccess:(CLLocation *)location{

    [MICBaiduMapHelper sharedMapHelper].currentLocation.gpsLocation = location;
    
}
// 当定位失败后，执行该方法

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
    NSLog(@"无法获得定位信息");
    
    
}



#pragma mark INSTRUCTION(指令)
///注册推送
-(void)registerForRemoteNotification:(NSNotification*)notification{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString *stringKey = [ud stringForKey:MIC_APPLICATION_ALIAS];
    
    [APService
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeNewsstandContentAvailability |
                                         UIRemoteNotificationTypeAlert |
                                         UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound)];
    
    
    [APService setTags:[NSSet setWithObjects:@"group",nil] alias:stringKey callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    
}
///取消推送
-(void)unRegisterForRemoteNotification:(NSNotification*)notification{
    
    [[UIApplication sharedApplication]unregisterForRemoteNotifications];
    
}
///检查更新
-(void)cheakUpdate:(NSNotification*)aNotification{
    [MICVersion versionCheakAscending:^(NSComparisonResult result, NSString *localVersion, NSString *version, NSString *strUrl, NSArray *updateLine) {
        dispatch_async(dispatch_get_main_queue(), ^{

            if (result == NSOrderedAscending) {
                self.updateUrl = strUrl;
                //需要更新
                UIAlertView *alertView = [[[UIAlertView alloc]initWithTitle:@"版本检测" message:@"本地安装的交通杭州服务有新版本哦" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"现在更新", nil] autorelease];
                alertView.tag = ALERT_VIEW_UPDATE_TAG;
                [alertView show];
            }else{
                if (aNotification.object && aNotification.object != self) {
                    [[[[UIAlertView alloc]initWithTitle:@"更新提醒" message:@"没有检测到新版本" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] autorelease] show];
                }
                
            }
        });
        
    }];
}
///登录
-(void)signIn:(NSNotification*)notification{
    
    
    
}
///登出
-(void)signOut:(NSNotification*)notification{
    
}

-(void)notification:(NSNotification *)notification{
    
    if ([notification.name isEqual:MIC_INSTRUCTION_LOADING]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            MICNetwork *network = [MICNetwork sharedMICNetwork];
            network.delegate = [ThirdnetProvider sharedInstance];
            
            //    NSDictionary *dic =
            [network httpRequestTest];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:MIC_INSTRUCTION_LOADED object:nil];
            });
            
        });

    }else if([notification.name isEqual:MIC_INSTRUCTION_LOADED]){
        
        //更新检查
        [[NSNotificationCenter defaultCenter] postNotificationName:MIC_INSTRUCTION_CHEAK_UPDATE object:nil];
        
    }
    
}
@end

