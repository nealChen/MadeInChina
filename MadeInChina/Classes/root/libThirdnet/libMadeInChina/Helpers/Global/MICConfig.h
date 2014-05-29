//
//  MICConfig.h
//  MadeInChina
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/*!
 @header
 @abstract MIC的配置信息
 @author Guofeng Wang
 @version 1.0.0.0 2013/09/10 Creation
 */

#ifndef MadeInChina_MICConfig_h
#define MadeInChina_MICConfig_h

//配置参数
#define APPLICATION_ID_KEY @"ApplicationID" //应用标识KEY

#define MIC_STRING_ENCODING NSUTF8StringEncoding            //框架使用编码

#define MIC_APPLICATION_NOTIFICATION_ENABLE_KEY \
    @"MIC_Application_Notification_Enable_Key"              //是否开启 Key

#define MIC_TOKEN_KEY @"MIC_Token_Key"                      //Token 的Key

#define MIC_APPLICATION_ID_KEY @"MIC_Application_Id_Key"    //应用程序ID Key

#define MIC_APPLICATION_RUNING_ID @"MIC_APPLICATION_RUNING_ID" //应用运行ID

#define MIC_APPLICATION_ALIAS @"MIC_APPLICATION_ALIAS" //应用程序别名(Alias）

#define MIC_NSUSERDATA_CURRENT_USERNAME_KEY @"MIC_CURRENT_USERNAME" ///当前账户key

#endif

#define MIC_CONFIG_FILE_NAME @"MICConfig"


@interface MICConfig : NSObject

+(id)sharedMICConfig;

-(void)loadConfig;

//@property (nonatomic,strong) NSString *ApplicationID;



@end
