//
//  NSBundle+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MadeInChinaLocalizedString(key) [[NSBundle MadeInChinaBundle] localizedStringForKey:(key) value:@"" table:@"MadeInChina"]

@interface NSBundle (MadeInChina)

+ (NSBundle *)MadeInChinaBundle;

@end
