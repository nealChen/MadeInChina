//
//  UIView+MadeInChina.h
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Provides extensions to `UIView` for various common tasks.
 */
@interface UIView (MadeInChina)

///-------------------------
/// @name Taking Screenshots
///-------------------------

/**
 Takes a screenshot of the underlying `CALayer` of the receiver and returns a `UIImage` object representation.
 
 @return An image representing the receiver
 */
- (UIImage *)imageRepresentation;


///-------------------------
/// @name Hiding and Showing
///-------------------------

/**
 Sets the `alpha` value of the receiver to `0.0`.
 */
- (void)hide;

/**
 Sets the `alpha` value of the receiver to `1.0`.
 */
- (void)show;


///------------------------
/// @name Fading In and Out
///------------------------

/**
 Fade out the receiver.
 
 The receiver will fade out in `0.2` seconds.
 */
- (void)fadeOut;

/**
 Fade out the receiver and remove from its super view
 
 The receiver will fade out in `0.2` seconds and be removed from its `superview` when the animation completes.
 */
- (void)fadeOutAndRemoveFromSuperview;

/**
 Fade in the receiver.
 
 The receiver will fade in in `0.2` seconds.
 */
- (void)fadeIn;


///----------------------------------
/// @name Managing the View Hierarchy
///----------------------------------

/**
 Returns an array of the receiver's superviews.
 
 The immediate super view is the first object in the array. The outer most super view is the last object in the array.
 
 @return An array of view objects containing the receiver
 */
- (NSArray *)superviews;

/**
 Returns the first super view of a given class.
 
 If a super view is not found for the given `superviewClass`, `nil` is returned.
 
 @param superviewClass A Class to search the `superviews` for
 
 @return A view object or `nil`
 */
- (id)firstSuperviewOfClass:(Class)superviewClass;

/**
 origin
 */
-(CGPoint)origin;

/**
 size
 */
-(CGSize)size;

/**
 width
 */
-(CGFloat)width;

/**
 height
 */
-(CGFloat)height;

/**
 x
 */
-(CGFloat)x;

/**
 y
 */
-(CGFloat)y;

@end
