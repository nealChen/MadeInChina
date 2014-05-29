//
//  JXTIIDatePicker.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXTIIDatePickerDelegate;

@interface JXTIIDatePicker : UIView{
    BOOL _isShow;
}

@property (strong,nonatomic)NSDateFormatter *formatter;
@property (strong,nonatomic)UIToolbar *toolBar;
@property (strong,nonatomic)UIDatePicker *datePicker;
@property (strong,nonatomic)id<JXTIIDatePickerDelegate>delegate;

- (void)datePickerHide;

- (void)datePickerShow;

- (BOOL)isShow;

@end

@protocol JXTIIDatePickerDelegate
 <NSObject>

-(void)datePickSelected:(JXTIIDatePicker*)sender;
@optional
-(void)datePickCancel;

@end