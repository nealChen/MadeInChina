//
//  JXTIIDatePicker.m
//  JiaXingTrafficII
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIDatePicker.h"

@implementation JXTIIDatePicker
@synthesize toolBar;

- (void)dealloc
{
    self.formatter = nil;
    self.delegate = nil;
    self.toolBar = nil;
    self.datePicker = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self setFrame:CGRectMake(0, 416 + (IPHONE_5 ? 88 : 0) - (162 + 44) , 320 ,162 + 44)];
        //创建工具栏
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:3];
        UIBarButtonItem *confirmBtn =
        MIC_AUTORELEASE([[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(confirmPickView)]);
        UIBarButtonItem *flexibleSpaceItem =
        MIC_AUTORELEASE([[UIBarButtonItem alloc]
                         initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                         target:nil
                         action:nil]);
        UIBarButtonItem *cancelBtn =
        MIC_AUTORELEASE([[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(datePickerHide)]);
        [items addObject:cancelBtn];
        [items addObject:flexibleSpaceItem];
        [items addObject:confirmBtn];
        
        [toolBar setItems:items animated:YES];
        
        [self addSubview:toolBar];
        
        [self setAlpha:0.0f];
        
        self.datePicker = MIC_AUTORELEASE([[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, 320, 162)]);
        [self addSubview:self.datePicker];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)datePickerHide
{
    _isShow = NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0.0f];
        [self setFrame:CGRectOffset(self.frame , 0, 162+44)];
    }];
}

- (void)datePickerShow{
    _isShow = YES;
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    if (self.alpha == 0.0f) {
        [UIView animateWithDuration:0.5 animations:^{
            [self setAlpha:1.0f];
            [self setFrame:CGRectMake(0, 416 + (IPHONE_5 ? 88 : 0) - (162 + 44) , 320 ,162 + 44)];
        }];
    }
}

-(BOOL)isShow{
    return _isShow;
}

-(void)confirmPickView
{
    //    for (NSString *row in [self.selectionStatesDic allKeys]) {
    //        if ([[self.selectionStatesDic objectForKey:row] boolValue]) {
    //            [self.selectedEntriesArr addObject:row];
    //        }
    //    }
    //
    //    //    CYLog(@"tempStr==%@",self.selectedEntriesArr);
    //
    //    if ([self.multiPickerDelegate respondsToSelector:@selector(returnChoosedPickerString:)]) {
    //        [self.multiPickerDelegate returnChoosedPickerString:self.selectedEntriesArr];
    //    }
    if ([self.delegate respondsToSelector:@selector(datePickSelected:)]) {
        [self.delegate datePickSelected:self];
    }
    
    [self datePickerHide];
}
@end
