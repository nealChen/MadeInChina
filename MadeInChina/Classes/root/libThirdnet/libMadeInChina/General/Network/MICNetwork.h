//
//  MICNetwork.h
//  MadeInChina
//
//  Created by mac on 13-9-6.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/*!
 @header
 @abstract MICNetwork.
 */

#import <Foundation/Foundation.h>
#import "MICHttpRequest.h"
#import "MICDESEncry.h"

/*!
 
 @typedef MICNetworkPercolator
 
 @abstract 错误过滤器.
 
 @param rawError 未经过处理的错误.
 
 @result 返回过滤后的错误.
 
 @discussion 为提供不显示部分错误信息的需求,过滤错误信息.
 
 */
//typedef NSError** (^MICNetworkPercolator)(NSError **rawError);

@protocol MICNetworkDelegate <NSObject>
/*!
 network启动之前的自检
 */
-(id)networkHttpRequestTest;
/*!
 User-Agent
 */
-(NSString*)networkHttpUserAgent;
/*!
 发送前的授权
 */
-(BOOL)shouldSend:(id)sender;
/*!
 提供请求的服务地址
 */
-(NSString*)networkHttpServiceAddress:(id)sender;
/*!
 提供发送地址
 */
-(NSString*)networkSendAddress:(id)sender;

/*!
 返回过滤器
 */
-(id)networkResponse:(id)sender;

@end

/*!
 @class
 @abstract 网络通信类
 */
@interface MICNetwork : NSObject

/*!
 network的控制对象
 */
@property (MIC_STRONG, nonatomic)id<MICNetworkDelegate> delegate;

/*!
 @method
 @abstract 获取一个共享的MICNetwork实例
 @discussion 该类产生的对象是单例。
 @result 返回MICNetwork实例
 */
+(MICNetwork *)sharedMICNetwork;
/*!
 新版HttpRequest
 */
-(id)httpRequest:(MICHttpBaseRequest *)httpRequest error:(NSError **)error;
/*!
 httpRequest自检
 */
-(id)httpRequestTest;

///*!
// @method
// @abstract 验证客户端信息.
// @param versionBlock
// 当验证完成后执行的Block[参数是(NSString＊)serverVersion,(NSString*)strUrl].
// */
//-(void)verifyLatestInfoWithPort:(NSString*)port versionSeletor:(void (^)(NSString* version,NSString *strUrl))versionBlock;
//
//
///*!
// @method
// @abstract 以put方式的Http请求（同步）
// @discussion
// @param portName 接口的名称
// @param usedName 接口的相对路径
// @param inputInfo put数据
// @param error 其中遇到的问题
// @result 返回服务回复
// */
//-(NSDictionary *)putInfoWithPort:(NSString *)portName usedPortName:(NSString*)usedName usedPostfix:(NSString*)postfix withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError**)error;
//
//-(NSDictionary *)putInfoWithPort:(NSString *)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError**)error;
//
///*!
// @method
// @abstract 以post方式的Http请求（同步）
// @discussion 
// @param portName 接口的名称
// @param usedName 接口的相对路径
// @param inputInfo post数据
// @param error 其中遇到的问题
// @result 返回服务回复
// */
//-(NSDictionary *)postInfoWithPort:(NSString *)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError**)error;
//
//-(NSDictionary *)postInfoWithPort:(NSString *)portName usedPortName:(NSString*)usedName usedPostfix:(NSString*)postfix withInPutPara:(NSMutableDictionary *)inputInfo error:(out NSError**)error;
//
///*!
// @method
// @abstract 以get方式的Http请求（同步）
// @discussion 
// @param portName 接口的名称
// @param usedName 接口的相对路径
// @param inputInfo get数据
// @param error 其中遇到的问题
// @result 返回服务回复
// */
//-(NSDictionary *)getInfoFromPort:(NSString *)portName usedPortName:(NSString *)usedName withInputPara:(NSDictionary *)inputInfo error:(NSError**)error;
//
//-(NSDictionary *)deleteInfoFromPort:(NSString *)portName usedPortName:(NSString *)usedName withInputPara:(NSDictionary *)inputInfo error:(NSError**)error;

/*!
 @method
 @abstract 以put方式的Http请求（异步）
 @discussion
 @param portName 接口的名称
 @param usedName 接口的相对路径
 @param inputInfo put数据
 @param delegate 请求的代理对象
 @result 返回请求是否成功发送
 */
//-(BOOL)putInfoWithPort:(NSString*)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary*)inputInfo andDelegate:(id)delegate;

/*!
 @method
 @abstract 以post方式的Http请求（异步）
 @discussion
 @param portName 接口的名称
 @param usedName 接口的相对路径
 @param inputInfo post数据
 @param delegate 请求的代理对象
 @result 返回请求是否成功发送
 */
//-(BOOL)postInfoWithPort:(NSString*)portName usedPortName:(NSString*)usedName withInPutPara:(NSMutableDictionary*)inputInfo andDelegate:(id)delegate;

/*!
 @method
 @abstract 以get方式的Http请求（异步）
 @discussion
 @param portName 接口的名称
 @param usedName 接口的相对路径
 @param inputInfo get数据
 @param delegate 请求的代理对象
 @result 返回请求是否成功发送
 */
//-(BOOL)getInfoFromPort:(NSString*)portName usedPortName:(NSString*)usedName  withInputPara:(NSDictionary*)inputInfo andDelegate:(id)delegate;

///*!
// @property
// @abstract 服务器地址.
// @discussion 单纯的服务器地址:简单的服务器地址,参考例子：http://api.baidu.com ,默认为http://127.0.0.1 .
// */
//@property (nonatomic,strong) NSString *serviceAddress;
//
///*!
// @property
// @abstract 请求超时时间.
// @discussion 请求等待时间,默认为8s.
// */
//@property (nonatomic,assign) NSTimeInterval timeOutSeconds;
//
///*!
// @property
// @abstract key模版.
// @discussion key的格式化模版,默认为 @"swkj_%@".
// */
//@property (nonatomic,strong) NSString *keyTemplate;
///*!
// @property
// @abstract iv模版.
// @discussion key的格式化模版,默认为 @"swkj_%@".
// */
//@property (nonatomic,strong) NSString *ivTempplate;
//
///*!
// @property
// @abstract 版本验证目录.
// @discussion 版本验证相对地址,默认为 @"latestinfo".
// */
//@property (nonatomic,strong) NSString *latestInfoPort;

@end
