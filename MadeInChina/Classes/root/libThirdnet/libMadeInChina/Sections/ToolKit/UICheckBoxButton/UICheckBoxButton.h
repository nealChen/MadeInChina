//
//  UICheckBoxButton.h
//  UICheckBox
//
//  Created by apple on 13-1-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckBoxButton : UIControl{
    UILabel *label;
    UIImageView *icon;
    BOOL checked;
    id delegate;
    NSString *paramCode;
    NSString *paramValue;
}

@property (nonatomic,retain) id delegate;
@property (nonatomic,retain) UILabel *label;
@property (nonatomic,retain) UIImageView *icon;
@property (nonatomic,retain) NSString *paramCode;
@property (nonatomic,retain) NSString *paramValue;

-(BOOL)isChecked;
-(void)setChecked:(BOOL)flag;
//显示内容和实际Value
-(void)setValue:(NSString *)Value withCode:(NSString *)Code;
//返回实际Value
-(NSString *)getCode;

@end


/*使用方法
 UICheckBoxButton *checkBoxButton = [[UICheckBoxButton alloc] initWithFrame:CGRectMake(30, 50, 220, 25)];
 checkBoxButton.delegate = self;
 [checkBoxButton setValue:@"test" withCode:@"aaa"];
 [self.view addSubview:checkBoxButton];
 [checkBoxButton release];
*/