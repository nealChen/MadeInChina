//
//  MICCommandManager.h
//  MadeInChina
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICCommandProtocol.h"

//命令文件的书写格式
#define MIC_COMMAND_FOR_STORE @"%@"

@interface MICCommandManager : NSObject

//获取管理对象
+(instancetype)sharedCommandManager;

- (int)executeCommandProviderWithName:(NSString*)command_name withObject:(id)obj completeBlock:(ResultBlock)result_block;

@end
