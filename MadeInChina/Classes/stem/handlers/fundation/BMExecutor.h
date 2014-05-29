//
//  BMExecutor.h
//  BusMapII
//
//  Created by mac on 14-2-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacro.h"

#define BMExecuteByClass(__class,__parameter) \
    [BMExecutor excuteForClass:__class andParameter:__parameter];

#define BMExecuteByClassFullName(__className,__parameter) \
    [BMExecutor excuteForClassFullName:__className andParameter:__parameter];

#define BMExecuteByClassShortName(__className,__parameter) \
    [BMExecutor excuteForClassShortName:__className andParameter:__parameter];


@protocol BMHandlerProtocol <NSObject>

-(id)Excute:(id)aObj;

@end

@interface BMExecutor : NSObject

AS_SINGLETON(BMExecutor);

+(id)excuteForClass:(Class)aClass andParameter:(id)aObj;

+(id)excuteForClassFullName:(NSString*)aClassName andParameter:(id)aObj;

+(id)excuteForClassShortName:(NSString*)aClassName andParameter:(id)aObj;

@end
