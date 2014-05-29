//
//  MICTableViewController.h
//  HzTraffic
//
//  Created by swkj001152 on 14-4-14.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICViewController.h"

@protocol MICTableViewControllerDelegate;

@interface MICTableViewController : MICViewController
<
UITableViewDataSource,
UITableViewDelegate
>

@property (MIC_WEAK,nonatomic)UITableView *tableView;
///数据源
@property (MIC_STRONG,nonatomic)NSArray *dataSource;
///代理对象
@property (MIC_WEAK,nonatomic)id<MICTableViewControllerDelegate> delegate;

@end


@protocol MICTableViewControllerDelegate <NSObject>

@optional
///选择数据回调
-(void)tableViewController:(MICTableViewController*)viewController
            chooseToIndexPath:(NSIndexPath*)indexPath;

@end