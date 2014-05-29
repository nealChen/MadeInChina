//
//  MICNetworkAndListViewController.m
//  MadeInChina
//
//  Created by mac on 13-9-17.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICNetworkAndListViewController.h"

@interface MICNetworkAndListViewController ()

@end

@implementation MICNetworkAndListViewController

@synthesize tableView;

- (void)dealloc
{
    self.tableView = nil;
    self.sourceArray = nil;
    self.rawSource = nil;
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
	
    if (!self.sourceArray) {
        self.sourceArray = [NSMutableArray array];
    }
    
    
    if (!tableView) {
        //支持xib的连接
        tableView = [[UITableView alloc]init];
        [tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark UITableViewDataSource(常规实现)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = MIC_AUTORELEASE([[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]);
    }
    return cell;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)table_View didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(selected:andValue:)]) {
        [_delegate selected:indexPath andValue:[self.sourceArray objectAtIndex:indexPath.row ]];
    }
    if ([_delegate respondsToSelector:@selector(selected:andValue:andTag:)]) {
        [_delegate selected:indexPath andValue:[self.sourceArray objectAtIndex:indexPath.row ]andTag:_Tag];
    }
    if ([self.delegate respondsToSelector:@selector(selected:andValue:andTag:Selector:)]) {
        [self.delegate selected:indexPath andValue:[[self.sourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]andTag:self.Tag Selector:self];
    }
}

@end
