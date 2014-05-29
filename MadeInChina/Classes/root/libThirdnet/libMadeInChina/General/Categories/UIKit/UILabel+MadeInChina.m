//
//  UILabel+MadeInChina.m
//  HzTraffic
//
//  Created by swkj001152 on 14-3-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "UILabel+MadeInChina.h"

@implementation UILabel (MadeInChina)

//根据要显示的text计算label高度
- (CGFloat)contentCellHeightWithText:(NSString*)text
{
    NSInteger ch;
    UIFont *font = [UIFont fontWithName:@"Arial" size:11];//11 一定要跟label的显示字体大小一致
    //设置字体
    CGSize size = CGSizeMake(300, 20000.0f);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)//IOS 7.0 以上
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else
    {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];//ios7以上已经摒弃的这个方法
    }
    ch = size.height;
    return ch;
}

@end
