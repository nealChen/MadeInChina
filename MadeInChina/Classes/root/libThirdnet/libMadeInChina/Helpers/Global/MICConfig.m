//
//  MICConfig.m
//  MadeInChina
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICConfig.h"
#import "OpenUDID.h"

static MICConfig *s_config;
@interface MICConfig(){
}

@end

@implementation MICConfig

+(id)sharedMICConfig{
    if (!s_config) {
        s_config = [[MICConfig alloc]init];
    }
    return s_config;
}

-(void)loadConfig{
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //分配运行ID
    NSString *runingId = [[OpenUDID value]stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
    //别名设置
    NSString *alias = [ud stringForKey:MIC_APPLICATION_ALIAS];
    if (!alias) {
        alias = runingId;//[OpenUDID value];
        [ud setObject:alias forKey:MIC_APPLICATION_ALIAS];
    }
    
    [ud setObject:runingId forKey:MIC_APPLICATION_RUNING_ID];
    [ud synchronize];
//    //读取plist
//    
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:MIC_CONFIG_FILE_NAME ofType:@"plist"];
//    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    NSLog(@"%@", data);
    
    //添加一项内容
//    [data setObject:@"add some content" forKey:@"c_key"];
    
    //获取应用程序沙盒的Documents目录
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *plistPath = [paths objectAtIndex:0];
    
    
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:MIC_CONFIG_FILE_NAME ofType:@"plist"];
//    NSDictionary *dic_config = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//    if (!dic_config) {
//        [self resetConfigInfo:plistPath];
//        [self loadConfig];
//    }else{
//    self.ApplicationID = [NSString stringWithFormat:@"%@",[dic_config objectForKey:APPLICATION_ID_KEY]];
//    }
//    [dic_config release];
    
    
//    //得到完整的文件名
//    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];
//    //输入写入
//    [data writeToFile:filename atomically:YES];
//    
//    //那怎么证明我的数据写入了呢？读出来看看
//    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
//    NSLog(@"%@", data1);
}

//-(BOOL)resetConfigInfo:(NSString*)path{
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:MIC_CONFIG_FILE_NAME ofType:@"plist"];
//    NSDictionary *config_t = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//    return [config_t writeToFile:path atomically:YES];
//}

@end
