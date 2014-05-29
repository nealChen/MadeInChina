//
//  JXTIIOnlineUserModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-10.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIUserModel.h"

@interface JXTIIOnlineUserModel : JXTIIUserModel

//图片路径
@property (strong,nonatomic)NSString *imagePath;

//登陆验证码
@property (strong,nonatomic)NSString *key;


@end
