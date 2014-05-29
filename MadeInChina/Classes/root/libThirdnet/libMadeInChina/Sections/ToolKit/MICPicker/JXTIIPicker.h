//
//  JXTIIPicker.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXTIIPickerDelegate ;

@interface JXTIIPicker : UIView

@property (strong,nonatomic)UIToolbar *toolBar;
@property (strong,nonatomic)UIPickerView *pickerView;
@property (assign,nonatomic)id<JXTIIPickerDelegate,UIPickerViewDelegate>delegate;
@property(nonatomic,assign) id<UIPickerViewDataSource> dataSource;


- (void)pickerHide;

- (void)pickerShow;

-(void)confirmPickView;

@end

@protocol JXTIIPickerDelegate <NSObject>

-(void)pickSelected:(NSUInteger)index value:(id)obj;
@optional
-(void)pickCancel;

@end