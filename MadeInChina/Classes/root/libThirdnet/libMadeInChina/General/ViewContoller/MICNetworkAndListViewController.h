//
//  MICNetworkAndListViewController.h
//  MadeInChina
//
//  Created by mac on 13-9-17.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICNetworkViewController.h"

@protocol MICListDelegate <NSObject>

@optional
- (void)selected:(NSIndexPath*)indexPath andValue:(id)value;
- (void)selected:(NSIndexPath*)indexPath andValue:(id)value andTag:(NSInteger)tag;
- (void)selected:(NSIndexPath*)indexPath andValue:(id)value andTag:(NSInteger)tag Selector:(id)sender;

@end

@interface MICNetworkAndListViewController : MICNetworkViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSDictionary *rawSource;

@property (strong,nonatomic) NSMutableArray *sourceArray;

@property (strong,nonatomic) id<MICListDelegate>delegate;

@property (assign,nonatomic) NSInteger Tag;

@end
