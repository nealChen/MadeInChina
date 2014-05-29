//
//  BMExecutor.m
//  BusMapII
//
//  Created by mac on 14-2-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BMExecutor.h"

#define CLASS_NAME_FORM @"BM%@Handler"

@implementation BMExecutor

DEF_SINGLETON(BMExecutor);

+(id)excuteForClass:(Class)aClass andParameter:(id)parameter{
    
    id result = nil;
    id obj = MIC_AUTORELEASE([[aClass alloc]init]);
    if ([obj conformsToProtocol:@protocol(BMHandlerProtocol)]) {
        result = [obj Excute:parameter];
    }
    
    return result;
}

+(id)excuteForClassFullName:(NSString *)aClassName andParameter:(id)aObj{
    
    return [self excuteForClass:NSClassFromString(aClassName) andParameter:aObj];
}

+(id)excuteForClassShortName:(NSString *)aClassName andParameter:(id)aObj{
    
    return [self excuteForClassFullName:[NSString stringWithFormat:CLASS_NAME_FORM,aClassName] andParameter:aObj];
    
}

@end
