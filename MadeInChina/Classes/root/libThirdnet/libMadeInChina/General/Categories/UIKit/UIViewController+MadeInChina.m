//
//  UIViewController+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UIViewController+MadeInChina.h"

@implementation UIViewController (MadeInChina)

- (void)displayError:(NSError *)error {
	if (!error) {
		return;
	}
	
	[self displayErrorString:[error localizedDescription]];
}


- (void)displayErrorString:(NSString *)string {
	if (!string || [string length] < 1) {
		return;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

-(CGSize)viewOfWindowSize{
    CGSize size = self.view.frame.size;
    if (self.navigationController) {
        if (!self.navigationController.navigationBarHidden) {
            if (self.navigationController.providesPresentationContextTransitionStyle) {
                size.height -=30;
            }
            size.height -= 44;
        }
    }
    return size;
}

@end
