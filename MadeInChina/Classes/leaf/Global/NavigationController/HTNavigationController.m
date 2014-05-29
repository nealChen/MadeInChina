//
//  HTNavigationController.m
//  HzTraffic
//
//  Created by swkj001152 on 14-4-14.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "HTNavigationController.h"

@interface HTNavigationController ()

@end

@implementation HTNavigationController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    HTNavigationController *nv = [super initWithRootViewController:rootViewController];
    nv.navigationBar.translucent = YES;
    nv.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [nv.navigationBar setBackgroundColor:[UIColor lightTextColor]];
    //    [nv.navigationBar setTintColor:[UIColor lightTextColor]];
    [nv.navigationBar setTintColor:[UIColor redColor]];
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [nv.navigationBar setBarTintColor:[UIColor whiteColor]];
    }
    
    UIImage *image = [UIImage imageNamed:@"navigation_bar_back_image"];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:1 topCapHeight:5];
    [nv.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    
    return nv;
}

@end
