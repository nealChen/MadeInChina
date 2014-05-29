//
//  UIViewController+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Provides extensions to `UIViewController` for various common tasks.
 */
@interface UIViewController (MadeInChina)

///------------------------
/// @name Presenting Errors
///------------------------

/**
 Present a `UIAlertView` with an error messagae.
 
 @param error Error to present.
 */
- (void)displayError:(NSError *)error;

/**
 Present a `UIAlertView` with an error messagae.
 
 @param string Error string to present.
 */
- (void)displayErrorString:(NSString *)string;

/*!
 窗口中视图的大小(当self.navigationController==nil 时，需要手动计算)
 */
- (CGSize)viewOfWindowSize;

@end
