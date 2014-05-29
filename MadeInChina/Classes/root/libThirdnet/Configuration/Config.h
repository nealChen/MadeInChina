//
//  NSObject_Config.h
//  HzTraffic
//
//  Created by  mac on 12-10-16.
//
//

#import <Foundation/Foundation.h>
#define APPURI @"https://itunes.apple.com/us/app/jiao-tong-hang-zhou/id587217449?ls=1&mt=8"  //应用地址
#define RTAURI @"http://www.hzcb.gov.cn/" //交通局官网


//合成地址
#define SynthesisOfLocalAddress(addrInfo) ({ \
        [NSString stringWithFormat:@"%@%@%@",addrInfo.addressComponent.district, \
        !addrInfo.addressComponent.streetName ? @"" : addrInfo.addressComponent.streetName ,!addrInfo.addressComponent.streetNumber ? @"" : addrInfo.addressComponent.streetNumber];\
})


#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568) //是否是IPhone5
#define BACK_IMAGE_TAG 444 //需要适配的背景图片Tag
#define FIT_SIZE     \
if (DEVICE_IS_IPHONE5) { \
    UIImageView * _backImage = (UIImageView*)[self.view viewWithTag:BACK_IMAGE_TAG]; \
    if(_backImage){ \
        _backImage.frame=CGRectMake(0, 0, 320, 416+(DEVICE_IS_IPHONE5?88:0)); \
    }      \
} //适配IPhone5


#define k_GUID @"GUID" //应用唯一标记key
#define k_APP_ID_KEY k_GUID //必须是“GUID”,与以前版本兼容
#define k_TOKEN_KEY @"Token"   //Token Key
#define k_ALIAS_KEY @"Alias"    //别名 Key

#define DATABASE_PATH @"com.zh.HzTraffic.database.sqlite"   //数据库名称
#define HISTORYCOUNT 6 //历史记录显示条数
#define KErrorContent @"与服务器断开连接，请重试！"
#define KUserDefaultsKey @"isShowGuide" //是否显示引导界面（用于存储的名称）
#define KUserDefaultsKey_Update [NSString stringWithFormat:@"%@_%@",KUserDefaultsKey,[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] //是否显示引导界面（更新刷新）
#define gradientBeginColor [[UIColor whiteColor] CGColor]//梯度开始颜色
#define gradientEndColor [[UIColor grayColor] CGColor]//梯度结束颜色
#define VERSION [[[UIDevice currentDevice] systemVersion] floatValue]//系统版本号
#define BUS_SPEED 30*1000/60//公交车速
#define URL_FLIGHT @"http://60.191.16.93:8090/queryFlight.aspx"//航班RUL
#define URL_AFFAIRS @"http://60.191.16.93:8090/queryKnowledge.aspx"//政务查询
#define URL_LOGISTICS @"http://gzcx.zjt.gov.cn/zje/wuliu/xjky/xjky.jsp"//物流
#define MURL @"http://60.191.16.93:10900/api/"//120.193.9.14  192.168.1.101  //正式60.191.16.93//肉哥192.168.1.244 //111.1.34.101
#define CITY @"杭州"
#define REQUEST_TYPE 1
#define QUERY_BUS_DISTANCE 500//搜索周边公交距离
#define QUERY_DISTANCE 1000 //搜索周边距离
#define QUERY_OTHER_DISTANCE 8000//搜索其它距离 包含 水上巴士、地铁、汽车站、火车站


#define k_SHARE_SDK_APP_KEY @"f640e8541a7" //ShareSDK的AppKey

#define k_SHARE_APP_KEY_SINA_WEIBO              @"3316814251"  // 新浪微博
#define k_SHARE_APP_SECRET_SINA_WEIBO           @"561ee10d56bd36fb94afdbf064c36f97"
#define k_SHARE_APP_REDIRECT_URI_SINA_WEIBO     @"http://www.sina.com"

#define k_SHARE_APP_KEY_TENCENT @"801460941" //腾讯微博
#define k_SHARE_APP_SECRET_TENCENT @"ccd842165fe1e46ba69b682aeb8816d9"
#define k_SHARE_APP_REDIRECT_URI_TENCENT @"http://www.hzcb.gov.cn/"

#define k_SHARE_APP_KEY_QQZone @"100584615"
#define k_SHARE_APP_SECRET_QQZone @"9cb7bed42d9bca87c8050ccef2309793"

#define k_SHARE_APP_KEY_WeChat @"wx53e611cc6c6d1692"  //微信开发者ID

#define QUICK_NAVIGATION @"quickNavigation"//快捷回家、回公司通知

@interface NSObject (){
}


@end

