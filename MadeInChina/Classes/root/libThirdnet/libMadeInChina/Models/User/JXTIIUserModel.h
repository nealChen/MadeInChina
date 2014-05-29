//
//  JXTIIUserModel.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-10.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXTIIUserModel : NSObject

@property (strong,nonatomic)UIImage *image;

@property (strong,nonatomic)NSString *sex;

@property (strong,nonatomic)NSString *name;

@property (strong,nonatomic)NSString *income;

@property (nonatomic,assign)int age;

@property (strong, nonatomic) NSString *phone;

@property (nonatomic, strong) NSString *phoneType;

@end
