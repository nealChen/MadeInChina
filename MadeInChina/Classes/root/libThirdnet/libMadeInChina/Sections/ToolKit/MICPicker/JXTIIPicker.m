//
//  JXTIIPicker.m
//  JiaXingTrafficII
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "JXTIIPicker.h"

@interface JXTIIPicker()<UIPickerViewDelegate>
{
    int __row,__component;
}
@end

@implementation JXTIIPicker
@synthesize toolBar;

- (void)dealloc
{
    self.delegate = nil;
    self.toolBar = nil;
    self.pickerView = nil;
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
        
        self.backgroundColor = [UIColor clearColor];
        toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self setFrame:CGRectMake(0, 416 + (IPHONE_5 ? 88 : 0) - (162 + 44) , 320 ,162 + 44)];
        
        //创建工具栏
        NSMutableArray *items = [NSMutableArray array];
        UIBarButtonItem *confirmBtn = MIC_AUTORELEASE([[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmPickView)]);
        UIBarButtonItem *flexibleSpaceItem = MIC_AUTORELEASE([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]);
        UIBarButtonItem *cancelBtn = MIC_AUTORELEASE([[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(pickCancel:)]);
        [items addObject:cancelBtn];
        [items addObject:flexibleSpaceItem];
        [items addObject:confirmBtn];
        
        [toolBar setItems:items animated:YES];
        
        [self addSubview:toolBar];
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, 320, 162)];
        [self addSubview:_pickerView];
        
        [self setAlpha:0.0f];
        
    }
    return self;
}

-(void)setDelegate:(id<JXTIIPickerDelegate,UIPickerViewDelegate>)delegate{
    _pickerView.delegate = delegate;
    _delegate = delegate;
}

-(void)setDataSource:(id<UIPickerViewDataSource>)dataSource{
    _pickerView.dataSource = dataSource;
    _dataSource = dataSource;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



- (void)pickerHide
{
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0.0f];
        [self setFrame:CGRectOffset(self.frame , 0, 162+44)];
    }];
}

- (void)pickerShow{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:1.0f];
        [self setFrame:CGRectMake(0, self.superview.frame.size.height - self.frame.size.height, self.frame.size.width ,self.frame.size.height)];
    }];
}

-(void)pickCancel:(id)sender{
    
    if ([self.delegate respondsToSelector:@selector(pickCancel)]) {
        [self.delegate pickCancel];
    }
    [self pickerHide];
}

-(void)confirmPickView
{

    if ([self.delegate respondsToSelector:@selector(pickSelected:value:)]) {
        [self.delegate pickSelected:__row value:[self pickerView:_pickerView titleForRow:__row forComponent:__component]];
    }
    [self pickerHide];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if ([self.delegate respondsToSelector:@selector(pickerView:widthForComponent:)]) {
        return [self.delegate pickerView:pickerView widthForComponent:component];
    }
    return 0.0f;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    if ([self.delegate respondsToSelector:@selector(pickerView:rowHeightForComponent:)]) {
        return [self.delegate pickerView:pickerView rowHeightForComponent:component];
    }
    return 0.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        [self.delegate pickerView:pickerView titleForRow:row forComponent:component];
    }
    return nil;
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0){
    if ([self.delegate respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]) {
        return [self.delegate pickerView:pickerView attributedTitleForRow:row forComponent:component];
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if ([self.delegate respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
        return [self.delegate pickerView:pickerView viewForRow:row forComponent:component reusingView:view];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    __row = row;
    __component = component;
    if ([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [self.delegate pickerView:pickerView didSelectRow:row inComponent:component];
    }
}

@end
