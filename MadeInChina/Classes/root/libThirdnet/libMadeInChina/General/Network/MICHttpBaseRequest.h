//
//  MICHttpBaseRequest.h
//  HzTraffic
//
//  Created by mac on 14-2-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacro.h"

@interface MICHttpBaseRequest : NSObject

//是否需要异步（当前版本支持同步请求）
@property (assign,nonatomic)BOOL isAsync;
//http的请求方式：GET/POST/PUT/DELETE
@property (copy,nonatomic)NSString *httpRequestMethod;
//服务器地址
@property (copy,nonatomic)NSString *serviceAddress;
//超时时间
@property (assign,nonatomic)NSTimeInterval timeOutSeconds;
/*!
 不安全的参数,暴露在外部的参数
 */
@property (MIC_STRONG,nonatomic)NSMutableDictionary *unSafeInfo;
/*!
 安全的参数,闷骚的参数,只在POST/PUT时有效
 */
@property (MIC_STRONG,nonatomic)NSMutableDictionary *safeInfo;

@end
