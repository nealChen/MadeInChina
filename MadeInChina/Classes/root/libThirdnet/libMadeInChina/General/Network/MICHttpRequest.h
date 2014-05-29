//
//  MICHttpRequest.h
//  BusMapII
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICHttpBaseRequest.h"

//HTTP请求方式
//const NSString *HTTPRequestMethod_OPTIONS		= @"OPTIONS";
//const NSString *HTTPRequestMethod_HEAD			= @"HEAD";
//const NSString *HTTPRequestMethod_GET			= @"GET";
//const NSString *HTTPRequestMethod_POST			= @"POST";
//const NSString *HTTPRequestMethod_PUT			= @"PUT";
//const NSString *HTTPRequestMethod_DELETE		= @"DELETE";
//const NSString *HTTPRequestMethod_TRACE			= @"TRACE";
//const NSString *HTTPRequestMethod_CONNECT		= @"CONNECT";

@interface MICHttpRequest : MICHttpBaseRequest

@property (MIC_STRONG,nonatomic)id key;

//相对路径
@property (MIC_STRONG,nonatomic)NSString *path;


@end
