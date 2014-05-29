//
//  MICMapAndNetworkViewController.h
//  MadeInChina
//
//  Created by mac on 13-9-13.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/*!
 @header
 @abstract MICMapAndNetworkViewController.
 */

#import "MICMapViewController.h"
#import "ASIHTTPRequest.h"
#import "MICNetwork.h"

/*!
 @class
 @abstract MICMapAndNetworkViewController父类.
 @discussion 所有的MapAndNetworkViewController都应该继承该类.
 */
@interface MICMapAndNetworkViewController : MICMapViewController<ASIHTTPRequestDelegate>

/*!
 @property
 @abstract 持有的网络通讯服务对象.
 @discussion 网络通讯均通过该对象实现.
 */
@property (nonatomic,strong)MICNetwork *network;

/*!
 @method
 @abstract 遇到一些错误可以调用这个函数
 @discussion
 */
-(void)someProblemInNetwork;

@end
