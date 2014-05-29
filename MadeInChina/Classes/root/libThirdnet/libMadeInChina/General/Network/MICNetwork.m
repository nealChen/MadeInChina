//
//  MICNetwork.m
//  MadeInChina
//
//  Created by mac on 13-9-6.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICNetwork.h"
#import "UtilsMacro.h"
#import "MICConfig.h"
#import "MICLog.h"
#import "JSONKit.h"
#import "UIApplication+MadeInChina.h"
#import "ASIFormDataRequest.h"
#import "UIDevice+MadeInChina.h"

@interface MICNetwork()

//@property (nonatomic,strong) NSString *key;
//@property (nonatomic,strong) NSString *iv;

@end

static MICNetwork *network = nil;
@implementation MICNetwork
//@synthesize serviceAddress,timeOutSeconds;
//@synthesize key,iv,keyTemplate,ivTempplate,latestInfoPort;

+(MICNetwork *)sharedMICNetwork{
    
    @synchronized(self){  //为了确保多线程情况下，仍然确保实体的唯一性
        
        if (!network) {

            network = [[self alloc] init]; //该方法会调用 allocWithZone
            
        }
        
    }
    
    return network;
    
}



+(id)allocWithZone:(NSZone *)zone{
    
    @synchronized(self){
        
        if (!network) {
            
            network = [super allocWithZone:zone]; //确保使用同一块内存地址
            
            return network;
            
        }
        
    }
    
    return nil;
    
}



- (id)copyWithZone:(NSZone *)zone;{
    
    return self; //确保copy对象也是唯一
    
}

#if ! __has_feature(objc_arc)



-(id)retain{
    
    return self; //确保计数唯一
    
}

- (NSUInteger)retainCount{
    
    return UINT_MAX;  //装逼用的，这样打印出来的计数永远为-1
    
}
//
//- (unsigned)retainCount
//
//{
//    
//    return UINT_MAX;  //装逼用的，这样打印出来的计数永远为-1
//    
//}



- (id)autorelease

{
    
    return self;//确保计数唯一
    
} 



- (oneway void)release

{
    
    //重写计数释放方法
    
}

#endif

#pragma mark 功能


//错误检测
-(NSString*)auditorWithCode:(int)code{
    switch (code) {
        case 200:
            
        case 201:
            return nil;
            break;
        default:{
            return @"请求失败,请稍后再试";
        }
            break;
    }
    //    2xx
    //    200
    //    201
    //    3xx
    //    303
    //    304
    //    4xx
    //    400
    //    401
    //    404
    //    5xx
    //    500
}

////获取客户端信息
//-(void)verifyLatestInfoWithPort:(NSString*)port versionSeletor:(void (^)(NSString* version,NSString *strUrl))versionBlock
//{
//    MICConfig *config = [MICConfig sharedMICConfig];
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
//
//-(void)verifyLatestInfoWithPort{
//    [self verifyLatestInfoWithPort:latestInfoPort versionSeletor:^(NSString *version, NSString *strUrl) {
//        
//    }];
//}

//是否允许运行
-(BOOL)canRun:(id)sender{

    if (_delegate) {
        return [_delegate shouldSend:sender];
    }else{
        return NO;
    }
    
}

-(id)httpRequestTest{
    
    return [self.delegate networkHttpRequestTest];
    
}

-(NSDictionary *)httpRequest:(MICHttpBaseRequest *)httpRequest error:(NSError **)error{
    
    if (![self canRun:httpRequest]) {
        return nil;
    }
    
    //当为空时,去代理获取服务地址
    if (!httpRequest.serviceAddress) {
        httpRequest.serviceAddress = [self.delegate networkHttpServiceAddress:httpRequest];
    }
    
    NSString *urlString = [self.delegate networkSendAddress:httpRequest];
    
    if (!urlString) {
        ERROR(@"URL为空");
        return nil;
    }
    
    NSLog(@"URL %@",urlString);
    
#ifdef DEBUG
    sleep(2);
#endif
    //    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //
    //    NSLog(@"%@",urlUTF8);
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:httpRequest.timeOutSeconds];
    [request setRequestMethod:httpRequest.httpRequestMethod];
    [request setStringEncoding:NSUTF8StringEncoding];
    [request addRequestHeader:@"User-Agent" value:[self.delegate networkHttpUserAgent]];
    request.shouldAttemptPersistentConnection = NO;//（不支持长连接）防止调用两次的情况
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    NSLog(@"RequestHeaders: \n%@",request.requestHeaders);
    
    if ([httpRequest.httpRequestMethod isEqual:@"POST"] || [httpRequest.httpRequestMethod isEqual:@"PUT"]) {

        NSString* jsonString=[httpRequest.safeInfo JSONString];
        NSData *jsonData=[jsonString dataUsingEncoding:MIC_STRING_ENCODING];
        [request setPostBody:(NSMutableData*)jsonData];
    }

    [request startSynchronous];
    
    (*error) = [request error];

    return [self.delegate networkResponse:request];
}


//delete同步通讯
/*
-(NSDictionary *)deleteInfoFromPort:(NSString *)portName usedPortName:(NSString *)usedName withInputPara:(NSDictionary *)inputInfo error:(NSError **)error{
//    if (!key || !iv) {
//        [self verifyLatestInfoWithPort];
//        if (!key || !iv) {
//            return nil;
//        }
//    }
 
    if (![self canRun:portName]) {
        return nil;
    }

    MICConfig *config = [MICConfig sharedMICConfig];
    NSString  *mic_des=[MICDESEncry encryptWithDES:portName Key:key Iv:iv];
    NSLog(@"key:%@,iv:%@",key,iv);
    NSLog(@"%@",portName);
    NSLog(@"%@",mic_des);
    
    mic_des=[MICDESEncry URLEscaped:mic_des];
    
    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",serviceAddress,usedName];
    for (NSString *paraKey in [inputInfo allKeys])
    {
        [urlString appendFormat:@"%@=%@&",paraKey,[MICDESEncry URLEscaped:[inputInfo objectForKey:paraKey]]];
    }
    [urlString appendFormat:@"Application=%@&",config.ApplicationID];
    [urlString appendFormat:@"code=%@",mic_des];
    
    NSLog(@"%@",urlString);
    //    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //
    //    NSLog(@"%@",urlUTF8);
    NSURL *url = [NSURL URLWithString:urlString];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:timeOutSeconds];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
    NSLog(@"%@",request.requestHeaders);
    request.shouldAttemptPersistentConnection = NO;//（不支持长连接）防止调用两次的情况
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request startSynchronous];
    
    int statusCode = [request responseStatusCode];
    ;
    NSString *statusMessage = [request responseStatusMessage];
    NSLog(@"%d %@",statusCode,statusMessage);
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    NSError *error_request = [request error];
    
    if (error_request)
    {
        NSError *httpError = [[[NSError alloc]initWithDomain:NetworkRequestErrorDomain code:error_request.code userInfo:error_request.userInfo]autorelease];
        (*error) = httpError;
    }else{
        NSString *strCodeError = [self auditorWithCode:statusCode];
        if (strCodeError) {
            NSError *codeError = [[[NSError alloc] initWithDomain:NetworkRequestErrorDomain code:statusCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:strCodeError,NSLocalizedDescriptionKey,nil]] autorelease];
            (*error) = codeError;
        }
        
    }
    
    NSDictionary *mi_response=[response objectFromJSONString];
    return mi_response;
}
 */

////put同步通信
//-(NSDictionary *)putInfoWithPort:(NSString *)portName usedPortName:(NSString *)usedName usedPostfix:(NSString *)postfix withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError **)error{
////    if (!key || !iv) {
////        [self verifyLatestInfoWithPort];
////        if (!key || !iv) {
////            return nil;
////        }
////    }
//    
//    if (![self canRun:portName]) {
//        return nil;
//    }
//    
//    MICConfig *config = [MICConfig sharedMICConfig];
//    NSString  *mic_des=[MICDESEncry encryptWithDES:portName Key:key Iv:iv];
//    mic_des=[MICDESEncry URLEscaped:mic_des];
//    
//    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",serviceAddress,usedName];
//    [urlString appendFormat:@"Application=%@&",config.ApplicationID];
//    [urlString appendFormat:@"code=%@",mic_des];
//    if (postfix) {
//        [urlString appendString:postfix];
//    }
//    
//    //    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    //    NSLog(@"%@",urlUTF8);
//    NSLog(@"%@",urlString);
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    NSString* jsonString=[inputInfo JSONString];
//    NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setTimeOutSeconds:timeOutSeconds];
//    [request setRequestMethod:@"PUT"];
//    [request setPostBody:(NSMutableData*)jsonData];
//    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request startSynchronous];
//    
//    
//    int statusCode = [request responseStatusCode];
//    NSString *statusMessage = [request responseStatusMessage];
//    NSLog(@"%d %@",statusCode,statusMessage);
//    NSString *response = [request responseString];
//    NSLog(@"%@",response);
//    
//    NSError *error_request = [request error];
//    
//    if (error_request)
//    {
//        NSError *httpError = [[[NSError alloc]initWithDomain:NetworkRequestErrorDomain code:error_request.code userInfo:error_request.userInfo]autorelease];
//        (*error) = httpError;
//    }else{
//        NSString *strCodeError = [self auditorWithCode:statusCode];
//        if (strCodeError) {
//            NSError *codeError = [[[NSError alloc] initWithDomain:NetworkRequestErrorDomain code:statusCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:strCodeError,NSLocalizedDescriptionKey,nil]] autorelease];
//            (*error) = codeError;
//        }
//        
//    }
//    
//    NSDictionary *mic_response=[response objectFromJSONString];
//    return mic_response;
//}
//
//-(NSDictionary *)putInfoWithPort:(NSString *)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError**)error
//{
//    
//    return [self putInfoWithPort:portName usedPortName:usedName usedPostfix:nil withInPutPara:inputInfo error:error];
//    
//}
//
//-(NSDictionary *)postInfoWithPort:(NSString *)portName usedPortName:(NSString*)usedName usedPostfix:(NSString*)postfix withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError**)error{
//    
////    if (!key || !iv) {
////        [self verifyLatestInfoWithPort];
////        if (!key || !iv) {
////            return nil;
////        }
////    }
//    
//    if (![self canRun:portName]) {
//        return nil;
//    }
//    
//    MICConfig *config = [MICConfig sharedMICConfig];
//    NSString  *mic_des=[MICDESEncry encryptWithDES:portName Key:key Iv:iv];
//    mic_des=[MICDESEncry URLEscaped:mic_des];
//    
//    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",serviceAddress,usedName];
//    [urlString appendFormat:@"Application=%@&",config.ApplicationID];
//    [urlString appendFormat:@"code=%@",mic_des];
//    if (postfix) {
//        [urlString appendString:postfix];
//    }
//    
//    //    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    //    NSLog(@"%@",urlUTF8);
//    NSLog(@"%@",urlString);
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    NSString* jsonString=[inputInfo JSONString];
//    NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setTimeOutSeconds:timeOutSeconds];
//    [request setRequestMethod:@"POST"];
//    [request setPostBody:(NSMutableData*)jsonData];
//    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request startSynchronous];
//    
//    
//    int statusCode = [request responseStatusCode];
//    NSString *statusMessage = [request responseStatusMessage];
//    NSLog(@"%d %@",statusCode,statusMessage);
//    NSString *response = [request responseString];
//    NSLog(@"%@",response);
//    
//    NSError *error_request = [request error];
//    
//    if (error_request)
//    {
//        NSError *httpError = [[[NSError alloc]initWithDomain:NetworkRequestErrorDomain code:error_request.code userInfo:error_request.userInfo]autorelease];
//        (*error) = httpError;
//    }else{
//        NSString *strCodeError = [self auditorWithCode:statusCode];
//        if (strCodeError) {
//            NSError *codeError = [[[NSError alloc] initWithDomain:NetworkRequestErrorDomain code:statusCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:strCodeError,NSLocalizedDescriptionKey,nil]] autorelease];
//            (*error) = codeError;
//        }
//        
//    }
//    
//    NSDictionary *mic_response=[response objectFromJSONString];
//    return mic_response;
//    
//}
//
////post同步通信
//-(NSDictionary *)postInfoWithPort:(NSString *)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError**)error
//{
//    return [self postInfoWithPort:portName usedPortName:usedName usedPostfix:nil withInPutPara:inputInfo error:error];
//}
//
//
//-(NSDictionary *)getInfoFromPort:(NSString *)portName usedPortName:(NSString *)usedName withInputPara:(NSDictionary *)inputInfo error:(NSError**)error
//{
//    
////    if (!key || !iv) {
////        [self verifyLatestInfoWithPort];
////        if (!key || !iv) {
////            return nil;
////        }
////    }
//    
//    if (![self canRun:portName]) {
//        return nil;
//    }
//    
//    MICConfig *config = [MICConfig sharedMICConfig];
//    NSString  *mic_des=[MICDESEncry encryptWithDES:portName Key:key Iv:iv];
//    NSLog(@"key:%@,iv:%@",key,iv);
//    NSLog(@"%@",portName);
//    NSLog(@"%@",mic_des);
//
//    mic_des=[MICDESEncry URLEscaped:mic_des];
//    
//    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",serviceAddress,usedName];
//    for (NSString *paraKey in [inputInfo allKeys])
//    {
//        [urlString appendFormat:@"%@=%@&",paraKey,[MICDESEncry URLEscaped:[inputInfo objectForKey:paraKey]]];
//    }
//    [urlString appendFormat:@"Application=%@&",config.ApplicationID];
//    [urlString appendFormat:@"code=%@",mic_des];
//
//    NSLog(@"%@",urlString);
////    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
////    
////    NSLog(@"%@",urlUTF8);
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setTimeOutSeconds:timeOutSeconds];
//    [request setRequestMethod:@"GET"];
//    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
//    NSLog(@"%@",request.requestHeaders);
//    
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request startSynchronous];
//    
//    int statusCode = [request responseStatusCode];
//    ;
//    NSString *statusMessage = [request responseStatusMessage];
//    NSLog(@"%d %@",statusCode,statusMessage);
//    NSString *response = [request responseString];
//    NSLog(@"%@",response);
//    NSError *error_request = [request error];
//    
//    if (error_request)
//    {
//        NSError *httpError = [[[NSError alloc]initWithDomain:NetworkRequestErrorDomain code:error_request.code userInfo:error_request.userInfo]autorelease];
//        (*error) = httpError;
//    }else{
//        NSString *strCodeError = [self auditorWithCode:statusCode];
//        if (strCodeError) {
//            NSError *codeError = [[[NSError alloc] initWithDomain:NetworkRequestErrorDomain code:statusCode userInfo:[NSDictionary dictionaryWithObjectsAndKeys:strCodeError,NSLocalizedDescriptionKey,nil]] autorelease];
//            (*error) = codeError;
//        }
//        
//    }
//    
//    NSDictionary *mi_response=[response objectFromJSONString];
//    return mi_response;
//}
//
//#pragma mark 异步通信
////put
//-(BOOL)putInfoWithPort:(NSString*)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary*)inputInfo andDelegate:(id)delegate
//{
////    if (!key || !iv) {
////        [self verifyLatestInfoWithPort];
////        if (!key || !iv) {
////            return NO;
////        }
////    }
//    
//    if (![self canRun:portName]) {
//        return NO;
//    }
//    
//    MICConfig *config = [MICConfig sharedMICConfig];
//    NSString  *mic_des=[MICDESEncry encryptWithDES:portName Key:key Iv:iv];
//    mic_des=[MICDESEncry URLEscaped:mic_des];
//    
//    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",serviceAddress,usedName];
//    [urlString appendFormat:@"Application=%@&",config.ApplicationID];
//    [urlString appendFormat:@"code=%@",mic_des];
//    
//    //    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlString);
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    NSString* jsonString=[inputInfo JSONString];
//    NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setTimeOutSeconds:timeOutSeconds];
//    [request setRequestMethod:@"PUT"];
//    [request setPostBody:(NSMutableData*)jsonData];
//    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request setDelegate:delegate];
//    [request startAsynchronous];
//    
//    return YES;
//}
//
////post
//-(BOOL)postInfoWithPort:(NSString*)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary*)inputInfo andDelegate:(id)delegate
//{
////    if (!key || !iv) {
////        [self verifyLatestInfoWithPort];
////        if (!key || !iv) {
////            return NO;
////        }
////    }
//    
//    if (![self canRun:portName]) {
//        return NO;
//    }
//    
//    MICConfig *config = [MICConfig sharedMICConfig];
//    NSString  *mic_des=[MICDESEncry encryptWithDES:portName Key:key Iv:iv];
//    mic_des=[MICDESEncry URLEscaped:mic_des];
//    
//    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",serviceAddress,usedName];
//    [urlString appendFormat:@"Application=%@&",config.ApplicationID];
//    [urlString appendFormat:@"code=%@",mic_des];
//    
////    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlString);
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    NSString* jsonString=[inputInfo JSONString];
//    NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setTimeOutSeconds:timeOutSeconds];
//    [request setRequestMethod:@"POST"];
//    [request setPostBody:(NSMutableData*)jsonData];
//    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request setDelegate:delegate];
//    [request startAsynchronous];
//
//    return YES;
//}
//
////get
//-(BOOL)getInfoFromPort:(NSString*)portName usedPortName:(NSString*)usedName  withInputPara:(NSDictionary*)inputInfo andDelegate:(id)delegate
//{
////    if (!key || !iv) {
////        [self verifyLatestInfoWithPort];
////        if (!key || !iv) {
////            return NO;
////        }
////    }
//    
//    if (![self canRun:portName]) {
//        return NO;
//    }
//    
//    MICConfig *config = [MICConfig sharedMICConfig];
//    NSString  *mic_des=[MICDESEncry encryptWithDES:portName Key:key Iv:iv];
//    mic_des=[MICDESEncry URLEscaped:mic_des];
//    
//    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@/?",serviceAddress,usedName];
//    for (NSString *paraKey in [inputInfo allKeys])
//    {
//        [urlString appendFormat:@"%@=%@&",paraKey,[MICDESEncry URLEscaped:[inputInfo objectForKey:paraKey]]];
//    }
//    [urlString appendFormat:@"Application=%@&",config.ApplicationID];
//    [urlString appendFormat:@"code=%@",mic_des];
//    
////    NSString *urlUTF8 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlString);
//    
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setRequestMethod:@"GET"];
//    [request addRequestHeader:@"User-Agent" value:[self getDeviceAndOSInfo]];
//    [request addRequestHeader:@"Content-Type" value:@"application/json"];
//    [request  setDelegate:delegate];
//    [request startAsynchronous];
//    return  YES;
//}
@end
