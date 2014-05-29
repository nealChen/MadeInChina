//
//  ThirdnetProvider.m
//  BusMapII
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ThirdnetProvider.h"
#import "MICDESEncry.h"
#import "JSONKit.h"
#import "UIDevice+MadeInChina.h"
#import "UIApplication+MadeInChina.h"
#import "ASIHTTPRequest.h"

#define HTTP_TEST @"HTTP_TEST"  //自检命令key

//#define SERVICE_APPLICATION_ID @"busdituiphone" //应用服务ID
#define SERVICE_APPLICATION_ID @"trafficcenterios" //应用服务ID

@interface ThirdnetProvider()
///加密Key
@property (MIC_STRONG,nonatomic)id key;
///加密Iv
@property (MIC_STRONG,nonatomic)id iv;
///当前版本号
@property (copy,nonatomic) NSString *version;
///更新地址
@property (copy,nonatomic) NSString *updateUrl;
///更新内容
@property (MIC_STRONG,nonatomic) NSArray *updateList;

@end

@implementation ThirdnetProvider
@synthesize key,iv;

DEF_SINGLETON(ThirdnetProvider);

-(void)dealloc{
    self.key = nil;
    self.iv = nil;
    self.version = nil;
    self.updateUrl = nil;
    self.updateList = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

-(NSString*)networkHttpUserAgent{
    
    NSString *osType = [[UIDevice currentDevice] systemVersion];
    NSString *appId = [UIApplication getApplacationId];
    NSLog(@"OS %@", osType);
    NSLog(@"AppID %@", appId);
    
    NSString *deviceInfo =  DeviceInfo();
    NSLog(@"%@",deviceInfo);
    
    return [ NSString stringWithFormat:@"%@ OS:%@||AppID:%@", DeviceInfo(),osType,appId];
    
}

-(BOOL)shouldSend:(id)sender{
    
    if (!key || !iv) {
        if ([sender isKindOfClass:[MICHttpRequest class]]) {
            MICHttpRequest *httpRequest = sender;
            //自检请求
            if ([httpRequest.key isEqual:HTTP_TEST]) {
                return YES;
            }
        }

        return NO;

    }else if ([key isEqual:[NSNull null]] && [iv isEqual:[NSNull null]]){
        
        return NO;
        
    }
    
    return YES;
}

-(NSString*)networkHttpServiceAddress:(id)sender{
//    return @"http://111.1.34.106:11001";
    return @"http://60.191.16.93:10900";
}

-(NSString*)networkSendAddress:(id)sender{

    if ([sender isKindOfClass:[MICHttpBaseRequest class]]) {
        if ([sender isKindOfClass:[MICHttpRequest class]]) {
            MICHttpRequest *httpRequest = sender;
            
            //自检的URL
            if ([httpRequest.key isEqual:HTTP_TEST]) {
                return [NSMutableString stringWithFormat:@"%@/%@",httpRequest.serviceAddress,httpRequest.path];
            }
            
            NSString  *mic_des=[MICDESEncry encryptWithDES:httpRequest.key Key:key Iv:iv];
    
            NSLog(@"key:%@,iv:%@",key,iv);
            NSLog(@"%@",httpRequest.key);

            mic_des=[MICDESEncry URLEscaped:mic_des];
            
            NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",httpRequest.serviceAddress,httpRequest.path];
            for (NSString *paraKey in [httpRequest.unSafeInfo allKeys])
            {
                [urlString appendFormat:@"%@=%@&",paraKey,[MICDESEncry URLEscaped:[httpRequest.unSafeInfo objectForKey:paraKey]]];
            }
            [urlString appendFormat:@"Application=%@&",SERVICE_APPLICATION_ID];
            [urlString appendFormat:@"code=%@",mic_des];
            return urlString;
        }else{
            MICHttpBaseRequest *httpRequest = sender;
            return httpRequest.serviceAddress;
        }
        
    }

    
    return nil;
    
}

-(id)networkResponse:(id)sender{
    
    if ([sender isKindOfClass:[ASIHTTPRequest class]]) {
        ASIHTTPRequest *request = sender;
        int statusCode = [request responseStatusCode];
        ;
        NSString *statusMessage = [request responseStatusMessage];
        NSLog(@"ResponseCode: %d Message: %@",statusCode,statusMessage);
        
        switch (statusCode) { //code 过滤
            case 0: ///请求超时
                return nil;
                break;
                
            default:
                break;
        }
        
        NSString *response = [request responseString];
//        NSLog(@"%@",response);
//        NSError *error_request = [request error];
        
//        if (error_request)
//        {
//            NSError *httpError = [[[NSError alloc]initWithDomain:NetworkRequestErrorDomain code:error_request.code userInfo:error_request.userInfo]autorelease];
//            (*error) = httpError;
//        }else{
//            NSString *strCodeError = [self auditorWithCode:statusCode];
//            if (strCodeError) {
//                NSError *codeError = [[[NSError alloc] initWithDomain:NetworkRequestErrorDomain code:statusCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:strCodeError,NSLocalizedDescriptionKey,nil]] autorelease];
//                (*error) = codeError;
//            }
//            
//        }
        NSDictionary *mic_response = nil;
        
        if (response && response.length > 0) {
            mic_response=[response objectFromJSONString];
        }
        NSLog(@"responseMessage:\n %@",mic_response);
        
        return mic_response;
    }
    
    return nil;
}

-(id)networkHttpRequestTest{
    
    MICNetwork *network = [MICNetwork sharedMICNetwork];
    MICHttpRequest *request = MIC_AUTORELEASE([[MICHttpRequest alloc]init]);
    request.key = @"HTTP_TEST";
    request.httpRequestMethod = @"GET";
//    request.serviceAddress = @"http://111.1.34.101:10100";
    request.path = [NSString stringWithFormat:@"latestinfo/%@",SERVICE_APPLICATION_ID];
    request.timeOutSeconds = 8;
    
    NSError *error;
    NSDictionary *dic = [network httpRequest:request error:&error];
    
//    NSLog(@"%@",dic);
    
//    NSDictionary *json=[response objectFromJSONString];
    
    id v1 = [dic objectForKey:@"V1"];
    id v2 = [dic objectForKey:@"V2"];
    if (v1&&v2) {
        self.key=[NSString stringWithFormat:@"swkjtr%@",v1];
        self.iv=[NSString stringWithFormat:@"swkjtr%@",v2];
    }else{
        NSAssert(!1, @"加密部分失败");
        self.key = [NSNull null];
        self.iv = [NSNull null];
    }
    
    self.version = [dic objectForKey:@"Version"];
    self.updateUrl = [dic objectForKey:@"Url"];
    self.updateList = [dic objectForKey:@"UpdateList"];
    

//    NSString *strServerVersion=[NSString stringWithFormat:@"%@",[dic objectForKey:@"Version"]];
//    NSString *strUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Url"]];
//    versionBlock(strServerVersion,strUrl);
    
    return dic;
}


//获取客户端信息
//-(void)verifyLatestInfoWithPort:(NSString*)port versionSeletor:(void (^)(NSString* version,NSString *strUrl))versionBlock
//{


    
////    MICConfig *config = [MICConfig sharedMICConfig];
//    NSString *urlString=[NSString stringWithFormat:@"%@/%@/%@",serviceAddress,latestInfoPort,config.ApplicationID];
//    //    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlString);
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request buildRequestHeaders];
//    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request startSynchronous];
//    NSError *error = [request error];
//    if (error)
//    {
//        NSLog(@"连接服务器错误");
//        return;
//    }
//    NSString *response = [request responseString];
//    NSLog(@"%@",response);
//    if (error) {
//        NSInteger tempInt=error.code;
//        NSLog(@"%ld  !! %@",(long)tempInt,error);
//    }
//    
//    int statusCode = [request responseStatusCode];
//    NSString *statusMessage = [request responseStatusMessage];
//    NSLog(@"[STATE] code:%d messge:%@",statusCode,statusMessage);
//    
//    //    NSLog(@"%@",response);
//    
//    
//    NSDictionary *json=[response objectFromJSONString];
//    self.key=[NSString stringWithFormat:keyTemplate,[json objectForKey:@"V1"]];
//    self.iv=[NSString stringWithFormat:ivTempplate,[json objectForKey:@"V2"]];
//    NSString *strServerVersion=[NSString stringWithFormat:@"%@",[json objectForKey:@"Version"]];
//    NSString *strUrl = [NSString stringWithFormat:@"%@",[json objectForKey:@"Url"]];
//    versionBlock(strServerVersion,strUrl);
//}

//-(void)verifyLatestInfoWithPort{
//    [self verifyLatestInfoWithPort:latestInfoPort versionSeletor:^(NSString *version, NSString *strUrl) {
//        
//    }];
//}


@end
