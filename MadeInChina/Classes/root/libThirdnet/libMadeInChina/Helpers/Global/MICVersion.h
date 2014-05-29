//
//  MICVersion.h
//  MadeInChina
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/*!
 @header
 @abstract 版本控制
 @discussion 
 */

#define MIC_VERSION @"1.0.0.0"  //当前版本号

#import <Foundation/Foundation.h>
/*!
 @class
 @abstract 该类控制整个MIC项目的版本.
 @discussion 该类还提供了版本的比较功能.
 */
@interface MICVersion : NSObject

/*!
 @method
 @abstract 获取MIC的Version.
 @discussion
 @result
 返回一个版本号.
 */
+(NSString*)getMICVersion;

/*!
 @method
 @abstract 获取本地的Version.
 @discussion
 @result
 返回一个本地版本号.
 */
+(NSString*)getLocalVersion;

/*!
 @method
 @abstract 验证版本信息.
 @discussion
 @param localVersion
 本地版本号.
 @param serverVersion
 服务器版本号.
 @result
 返回版本对比结果.
 */
+(NSComparisonResult)comparisonVersionByLocalVersion:(NSString*)localVersion andServerVersion:(NSString *)serverVersion;

/*!
 @method
 @abstract 验证版本信息.
 @discussion
 @param localVersion
 本地版本号.
 @param serverVersion
 服务器版本号.
 @param cmptr
 对比器.
 @result
 返回版本对比结果.
 */
+(NSComparisonResult)comparisonVersionByLocalVersion:(NSString*)localVersion andServerVersion:(NSString *)serverVersion usingCompartor:(NSComparator)cmptr;

/*!
 @method
 @abstract 是否需要更新.
 @discussion 
 @param localVersion
 本地版本号.
 @param serverVersion
 服务器版本号.
 @result
 返回是否需要更新.
 */
+(BOOL)isUpdateWithLocalVersion:(NSString*)localVersion andServerVersion:(NSString *)serverVersion;

@end

//typedef VersionBlock (void (^)(NSComparisonResult result,NSString *localVersion,NSString* version,NSString *strUrl,NSArray *updateLine));

@interface MICVersion (ThirdNet)

///快捷更新检测
+(void)versionCheakAscending:(void (^)(NSComparisonResult result,NSString *localVersion,NSString* version,NSString *strUrl,NSArray *updateLine))ascBlock;

@end
