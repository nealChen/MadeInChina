//
//  MICViewController.m
//  MadeInChina
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICViewController.h"

#import "MobClick.h"

#ifndef CATransitionType
#define CATransitionType
///过渡效果
NSString *const CATransitionTypeCube = @"cube";
NSString *const CATransitionTypeMoveIn = @"moveIn";
NSString *const CATransitionTypeReveal = @"reveal";
NSString *const CATransitionTypeFade = @"fade";
NSString *const CATransitionTypePageCurl = @"pageCurl";
NSString *const CATransitionTypePageUnCurl = @"pageUnCurl";
DEPRECATED_MSG_ATTRIBUTE("private property")
NSString *const CATransitionTypeSuckEffect = @"suckEffect";
DEPRECATED_MSG_ATTRIBUTE("private property")
NSString *const CATransitionTypeRippleEffect = @"rippleEffect";
NSString *const CATransitionTypeOglFlip = @"oglFlip";
#endif

@interface MICViewController ()

@end

@implementation MICViewController
@synthesize HUD;
- (void)dealloc
{
    self.HUD = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IPHONE_5) {
//        [self resizeSubViews];
    }
    
    self.wantsFullScreenLayout = YES;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif  // #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    
    //适配
    UIScreen *myScreen = [UIScreen mainScreen];
    UIDevice *myDevice = [UIDevice currentDevice];
    
    [self resizeSubViewsByScreenMode:[myScreen currentMode] andOSVersion:[myDevice systemVersion]];
    
    [self resizeSubViewsByScreenSize:[myScreen currentMode].size andOSVersion:[myDevice systemVersion]];

    [self resizeSubViewsByWindowSize:self.view.window.frame.size andOSVersion:[myDevice systemVersion]];
    
    [self resizeSubViewsByViewSize:self.view.frame.size andOSVersion:[myDevice systemVersion]];
    
    UITapGestureRecognizer *tapGr =
    MIC_AUTORELEASE([[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(viewTapped:)]);
    tapGr.delegate = self;
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];

	[self resetNavigationbarItemButton];

}

-(void)viewWillAppear:(BOOL)animated{
    
    ///过渡效果
    if ([self respondsToSelector:@selector(viewWillAppearWithAnimated)]) {
        CATransition *transition = [self viewWillAppearWithAnimated];
        if (transition) {
            [self.navigationController.view.layer
             addAnimation:transition
             forKey:nil];
        }
        
    }
    
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
    
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self removeHUD];
    
    ///过渡效果
    if ([self respondsToSelector:@selector(viewWillDisappearWithAnimated)]) {
        CATransition *transition = [self viewWillDisappearWithAnimated];
        if (transition) {
            [self.navigationController.view.layer
             addAnimation:transition
             forKey:nil];
        }
        
    }
    
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",[self class]]];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && self.view.window == nil) {
        self.view = nil;
    }
    
}

-(void)resizeSubViews{

}

-(void)resizeSubViewsByScreenMode:(UIScreenMode *)screenMode andOSVersion:(NSString *)osVersion{

}

-(void)resizeSubViewsByScreenSize:(CGSize)windowSize andOSVersion:(NSString *)osVersion{

}

-(void)resizeSubViewsByViewSize:(CGSize)viewSize andOSVersion:(NSString*)version{

}

-(void)resizeSubViewsByWindowSize:(CGSize)windowSize andOSVersion:(NSString*)version{
    
}

- (void)resetNavigationbarItemButton{
    
}

- (void)popViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//显示菊花
- (void)showWaitingToHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeHUD:^{
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.dimBackground = NO;
            HUD.delegate=self;
            [self.view bringSubviewToFront:HUD];
            HUD.labelText = @"请稍等";
            [HUD show:NO];
        }];
    });
}

//显示健壮的菊花
- (void)showStrongWaitingToHUD:(MICCompletionBlock)completionBlock{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeHUD:^{
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.dimBackground = NO;
            HUD.delegate=self;
            [self.view bringSubviewToFront:HUD];
            HUD.labelText = @"请稍等";
            [HUD show:NO];
            completionBlock();
        }];
    });
}

//Tosat消息＋Mode
- (void)showTosat:(NSString*)message andMode:(MBProgressHUDMode)mode{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [self removeHUD];
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD];
        
        HUD.dimBackground = NO;
        
        HUD.mode = mode;
        
        HUD.delegate=self;
        
        [self.view bringSubviewToFront:HUD];
        
        HUD.labelText = message;
        
        [HUD show:NO];
        
        [HUD hide:YES afterDelay:2];
        
        self.HUD.delegate = nil;
        
        self.HUD = nil;
        
        
    });
    
}
//Tosat消息
- (void)showTosat:(NSString*)message{

    [self showTosat:message andMode:MBProgressHUDModeCustomView];
    
}
//移除HUD
- (void)removeHUD{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (HUD) {
            [HUD removeFromSuperview];
            [HUD hide:NO];
            self.HUD=nil;
        }
    });
}

- (void)removeHUD:(MICCompletionBlock)completionBlock{

    dispatch_async(dispatch_get_main_queue(), ^{
        if (HUD) {
            [HUD removeFromSuperview];
            [HUD hide:NO];
            self.HUD=nil;
        }
        completionBlock();
    });
    
}

//提示信息的方法
- (void)showMessageBox:(NSString*)title Message:(NSString*)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
        
#if ! __has_feature(objc_arc)
       [alertView release];
#endif
    });
}


- (void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.view endEditing:YES];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    [theTextField resignFirstResponder];
    return YES;
}

#pragma mark Transition 

#pragma mark 5.0+
//[self addChildViewController:toVC];
//[fromVC willMoveToParentViewController:nil];
//[self.view addSubview:toVC.view];
//
//__weak id weakSelf = self;
//[self transitionFromViewController:fromVC
//                  toViewController:toVC duration:0.3
//                           options:UIViewAnimationOptionTransitionCrossDissolve
//                        animations:^{}
//                        completion:^(BOOL finished) {
//                            [fromVC.view removeFromSuperView];
//                            [fromVC removeFromParentViewController];
//                            [toVC didMoveToParentViewController:weakSelf];
//                        }];
#pragma mark 7.0+
//@protocol UIViewControllerContextTransitioning
-(CATransition *)transitionFactoryWithTransitionType:(NSString *)transitionType
                                    functionWithName:(NSString *)name
                                  transitionFromType:(NSString *)transitionFromType{
    
    CATransition *transition = [CATransition animation];
    
    transition.duration = 0.5f;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:name]; /* 动画的开始与结束的快慢*/
    
    transition.type = transitionType;//私有属性无法上架
    //@"cube" @"moveIn" @"reveal" @"fade"(default) @"pageCurl" @"pageUnCurl" @"suckEffect" @"rippleEffect" @"oglFlip"
    transition.subtype = transitionFromType;
//    kCATransitionFromRight
    transition.delegate = self;
    
    return transition;

}
@end

