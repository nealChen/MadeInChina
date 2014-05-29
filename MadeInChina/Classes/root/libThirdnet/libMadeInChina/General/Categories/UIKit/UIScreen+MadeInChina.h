//
//  UIScreen+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Provides extensions to `UIScreen` for various common tasks.
 */
@interface UIScreen (MadeInChina)

///---------------------------
/// @name Accessing the Bounds
///---------------------------

/**
 Returns the bounds of the screen for the current device orientation.
 
 @return A rect indicating the bounds of the screen.
 
 @see boundsForOrientation:
 */
- (CGRect)currentBounds;

/**
 Returns the bounds of the screen for a given device orientation. `UIScreen`'s `bounds` method always returns the bounds
 of the screen of it in the portrait orientation.
 
 @param orientation The orientation to get the screen's bounds.
 
 @return A rect indicating the bounds of the screen.
 
 @see currentBounds
 */
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;


///------------------------
/// @name Screen Attributes
///------------------------

/**
 Returns a Boolean indicating if the screen is a Retina display.
 
 @return A Boolean indicating if the screen is a Retina display.
 */
- (BOOL)isRetinaDisplay;

@end
