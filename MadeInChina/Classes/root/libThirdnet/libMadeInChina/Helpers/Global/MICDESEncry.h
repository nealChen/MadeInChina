//
//  DESEncry.h
//  TextProject
//
//  Created by sanwangkeji on 13-3-5.
//  Copyright (c) 2013年 sanwangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MyMethods)

@end

@interface MICDESEncry : NSObject
+ (NSString *)URLEscaped:(NSString *)str;
+ (NSString *)UnescapingFromURLQuery :(NSString*)str;
+ (NSString *)EscapingForURLQuery :(NSString*)str;

+(NSString *)encryptWithDES:(NSString *)plainText Key:(NSString *)strKey Iv:(NSString*)strIv;
@end


