//
//  MICVersion.m
//  MadeInChina
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICVersion.h"
#import "ThirdnetProvider.h"
#import <objc/runtime.h>

@implementation MICVersion

+(NSString*)getMICVersion{
    return MIC_VERSION;
}

+(NSString *)getLocalVersion{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
}

+(NSComparisonResult)comparisonVersionByLocalVersion:(NSString*)localVersion andServerVersion:(NSString *)serverVersion{
    
     return [self comparisonVersionByLocalVersion:localVersion andServerVersion:serverVersion usingCompartor:^NSComparisonResult(id obj1, id obj2) {
        @try {
            
            NSArray *array_serverVersion=[serverVersion componentsSeparatedByString:@"."];
            
            NSArray *array_localVersion=[localVersion componentsSeparatedByString:@"."];
            
            for (int i=0; i<[array_serverVersion count]; i++) {
                if (i>=[array_localVersion count]) {
                    if (0 <[[array_serverVersion objectAtIndex:i] intValue]) {
                        return NSOrderedAscending;
                    }
                }else{
                    if ([[array_serverVersion objectAtIndex:i] intValue]>[[array_localVersion objectAtIndex:i] intValue]) {
                        return  NSOrderedAscending;
                    }
                }
                
            }
            
            if ([serverVersion isEqual:localVersion]) {
                return NSOrderedSame;
            }else{
                return NSOrderedDescending;
            }
            
        }
        @catch (NSException *exception) {
            return ![serverVersion isEqual:localVersion];
        }
        @finally {
            
        }
    }];
    
}

+(NSComparisonResult)comparisonVersionByLocalVersion:(NSString*)localVersion andServerVersion:(NSString *)serverVersion usingCompartor:(NSComparator)cmptr{

    return cmptr(serverVersion,localVersion);
    
}



//-(void)resultData:(NSString *)result IndexPath:(NSIndexPath *)indexPath{
//    CLog(@"收到：%@",result);
//    NSDictionary *items =[[result  objectFromJSONStringWithParseOptions:JKParseOptionValidFlags] retain];
//    NSString *code=[items objectForKey:@"code"];
//    if (code.intValue==200) {
//        //        CLog(@"版本号:%@",[items objectForKey:@"version"]);
//        
//        //        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        //        appDelegate.versionDic=[items objectForKey:@"version"];
//        [versionContenntDictionary setObject:[items objectForKey:@"version"] forKey:@"version"];
//        [versionContenntDictionary setObject:[items objectForKey:@"url"] forKey:@"url"];
//        //        appDelegate.versionDic=dic;
//        
//        [MUtility setKey:[items objectForKey:@"v1"] Ver:[items objectForKey:@"v2"]];
//        //检测是否有新版本
//        NSString *localVersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//CFBundleShortVersionString取的是长Version  CFBundleVersion取的是Build
//        NSString * serverVersion = [versionContenntDictionary objectForKey:@"version"];
//        
//        //        CLog(@"localVersion:%@",[localVersion description]);
//        
//        //        NSArray *temp=[NSArray arrayWithObjects:@"1",@"1",@"0", nil];
//        BOOL isUpdate=[self isUpdate:serverVersion :localVersion];
//        if (!isUpdate) {
//            [self performSelectorOnMainThread:@selector(pushView:) withObject:nil waitUntilDone:YES];
//        }else{
//            UIAlertView *alert=[[UIAlertView alloc]
//                                initWithTitle:@"版本检测"
//                                message:@"检测到新的版本，是否现在更新？"
//                                delegate:self
//                                cancelButtonTitle:@"现在更新"
//                                otherButtonTitles:@"稍后再说", nil];
//            alert.tag=1;
//            [alert show];
//            [alert release];
//        }
//        
//        
//        
//    }else{
//        [Tools showMessgae:[items objectForKey:@"error"]];
//    }
//    [items release];
//}
+(BOOL)isUpdateWithLocalVersion:(NSString*)localVersion andServerVersion:(NSString *)serverVersion{

    return [self comparisonVersionByLocalVersion:localVersion andServerVersion:serverVersion] == NSOrderedAscending;
    
}
@end

@implementation MICVersion (ThirdNet)

+(void)versionCheakAscending:(void (^)(NSComparisonResult, NSString *, NSString *, NSString *, NSArray *))ascBlock{

    ThirdnetProvider *provider = [ThirdnetProvider sharedInstance];
    
    NSString *updateUrl = nil;
    NSString *version = nil;
    NSArray *updateList = nil;
    //获取当前版本号
    
    object_getInstanceVariable(provider, "_version", (void *)&version);
    object_getInstanceVariable(provider, "_updateUrl", (void *)&updateUrl);
    object_getInstanceVariable(provider, "_updateList", (void *)&updateList);

    NSString *localVersion = [self getLocalVersion];
    
    NSComparisonResult result = [self comparisonVersionByLocalVersion:localVersion andServerVersion:version];
    ascBlock(result,localVersion,version,updateUrl,updateList);
    
    
}


@end
