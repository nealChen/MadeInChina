//
//  NSNumber+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (MadeInChina)
///--------------
/// @name Date from timestamp
///--------------

/**
 Creates an instance of `NSDate` using current number as timestamp.
 @return NSDate with current number as unix timestamp or `nil` if current number contains 0.
 */
- (NSDate *)dateValue;

@end
