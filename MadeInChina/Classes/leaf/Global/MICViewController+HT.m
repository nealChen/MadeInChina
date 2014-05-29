//
//  MICViewController+HT.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICViewController+HT.h"

@implementation MICViewController (HT)

-(void)resetNavigationbarItemButton{

    if (self.navigationController.viewControllers.count > 1) {
        [self restoreBackBarButtonItem];
    }
    
}

//恢复返回按钮
-(void)restoreBackBarButtonItem{

    UIButton *BackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//[[[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 55, 34)] autorelease];
//    [BackBtn setTitle:@"  返回" forState:UIControlStateNormal];
//    [BackBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0f]];
//    [BackBtn.titleLabel setTextAlignment:NSTextAlignmentRight];

    [BackBtn setImage:ImageNamed(@"back") forState:UIControlStateNormal];
    [BackBtn setFrame:CGRectMake(0, 0, 20, 34)];

    [BackBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *BackBarBtn = MIC_AUTORELEASE([[UIBarButtonItem alloc] initWithCustomView:BackBtn]);
    
    self.navigationItem.leftBarButtonItem = BackBarBtn;

}
@end
