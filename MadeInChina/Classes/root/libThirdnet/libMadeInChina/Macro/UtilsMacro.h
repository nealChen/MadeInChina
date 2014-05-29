//
//  UtilsMacro.h
//  MadeInChina
// MadeInChina中 一些方便使用的宏定义
//  Created by sanwangkeji on 13-11-19.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#ifndef MadeInChina_UtilsMacro_h
#define MadeInChina_UtilsMacro_h

//iPhone5判断
#define IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//IOS5
#define IOS5_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
//IOS6
#define IOS6_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
//IOS7
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

//ARC下
    #ifndef MIC_STRONG
    #if __has_feature(objc_arc)
    #define MIC_STRONG strong
    #else
    #define MIC_STRONG retain
    #endif
    #endif

    #ifndef MIC_WEAK
    #if __has_feature(objc_arc_weak)
    #define MIC_WEAK weak
    #elif __has_feature(objc_arc)
    #define MIC_WEAK unsafe_unretained
    #else
    #define MIC_WEAK assign
    #endif
    #endif

    #if __has_feature(objc_arc)
    #define MIC_AUTORELEASE(exp) (exp)
    #define MIC_RELEASE(exp) exp
    #define MIC_RETAIN(exp) exp
    #else
    #define MIC_AUTORELEASE(exp) [exp autorelease]
    #define MIC_RELEASE(exp) [exp release]
    #define MIC_RETAIN(exp) [exp retain]
    #endif
//单例声明
    #undef	AS_SINGLETON
    #define AS_SINGLETON( __class ) \
    - (__class *)sharedInstance; \
    + (__class *)sharedInstance;

    #undef	DEF_SINGLETON
    #define DEF_SINGLETON( __class ) \
    - (__class *)sharedInstance \
    { \
    return [__class sharedInstance]; \
    } \
    + (__class *)sharedInstance \
    { \
    static dispatch_once_t once; \
    static __class * __singleton__; \
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
    return __singleton__; \
    }

    #undef	DEF_SINGLETON_AUTOLOAD
    #define DEF_SINGLETON_AUTOLOAD( __class ) \
    - (__class *)sharedInstance \
    { \
    return [__class sharedInstance]; \
    } \
    + (__class *)sharedInstance \
    { \
    static dispatch_once_t once; \
    static __class * __singleton__; \
    dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
    return __singleton__; \
    } \
    + (void)load \
    { \
    [self sharedInstance]; \
    }
  

#endif





