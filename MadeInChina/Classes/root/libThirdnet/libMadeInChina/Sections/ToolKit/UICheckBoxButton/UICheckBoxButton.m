//
//  UICheckBoxButton.m
//  UICheckBox
//
//  Created by apple on 13-1-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "UICheckBoxButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation UICheckBoxButton
@synthesize label,icon,delegate,paramCode,paramValue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.height)];
        [icon setImage:ImageNamed(@"checkbox")];
        [self setChecked:NO];
        [self addSubview:icon];
        label = [[UILabel alloc] initWithFrame:CGRectMake(icon.frame.size.width+7, 0, frame.size.width-icon.frame.size.width-10, frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
        
        
//        //    icon.backgroundColor = [UIColor whiteColor];
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = icon.bounds;
//        gradient.cornerRadius = 3;
//        [icon.layer insertSublayer:gradient atIndex:0];
        
        
        
//        if (VERSION>=3.2) {
//            //阴影
//            icon.layer.shadowPath =[UIBezierPath bezierPathWithRect:icon.bounds].CGPath;
//            icon.layer.shadowColor =[[UIColor blackColor] CGColor] ;
//            icon.layer.shadowOffset = CGSizeMake(0.0f, 0.0f); // [水平偏移, 垂直偏移]
//            icon.layer.shadowOpacity = 1.0f; // 0.0 ~ 1.0 的值
//            icon.layer.shadowRadius = 6.0f; // 陰影發散的程度
//            //按键阴影
//            label.layer.shadowPath =[UIBezierPath bezierPathWithRect:label.bounds].CGPath;
//            label.layer.shadowColor = [[UIColor blackColor] CGColor];
//            label.layer.shadowOffset = CGSizeMake(1.0f, 1.0f); // [水平偏移, 垂直偏移]
//            label.layer.shadowOpacity = 0.6f; // 0.0 ~ 1.0 的值
//            label.layer.shadowRadius = 3.0f; // 陰影發散的程度
//        }
        
//        UIImageView *imge =[[UIImageView alloc]initWithImage: [UIImage imageNamed:@"checkbox_Selected.png"]];
//        [imge setHidden:YES];
//        [icon addSubview:imge];
    }
    return self;
}

-(BOOL)isChecked{
    return checked;
}

-(void)setChecked:(BOOL)flag{
    if (flag != checked) {
        checked = flag;
    }
    

    
    if (checked) {
        
        UIImageView *imageView = [[[UIImageView alloc]initWithFrame:CGRectMake(3, -5, self.frame.size.height, self.frame.size.height)] autorelease];
        [imageView setImage:ImageNamed(@"checkbox_Selected")];
        [icon addSubview:imageView];

    }else{
        
        for (UIView *view in icon.subviews) {
            [view removeFromSuperview];
        }
    }
    
//    CALayer *layer = [icon layer];   //获取ImageView的层
//    [layer setMasksToBounds:YES];
//    [layer setCornerRadius:4];
//    if (VERSION>=3.2) {
//        //阴影
//        layer.shadowPath =[UIBezierPath bezierPathWithRect:icon.bounds].CGPath;
//        layer.shadowColor =[[UIColor blackColor] CGColor] ;
//        layer.shadowOffset = CGSizeMake(0.0f, 0.0f); // [水平偏移, 垂直偏移]
//        layer.shadowOpacity = 1.0f; // 0.0 ~ 1.0 的值
//        layer.shadowRadius = 6.0f; // 陰影發散的程度
//    }
}

-(void)clicked{
    [self setChecked:!checked];
    if (delegate != nil) {
        SEL sel = NSSelectorFromString(@"checkButtonClicked");
        if ([delegate respondsToSelector:sel]) {
            [delegate performSelector:sel];
        }
    }
}

-(void)setValue:(NSString *)Value withCode:(NSString *)Code{
    NSCharacterSet *space = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmValue = [Value stringByTrimmingCharactersInSet:space];
    NSString *trimmCode = [Code stringByTrimmingCharactersInSet:space];
    if (trimmCode.length == 0 && trimmValue.length == 0) {
        return;
    }else{
        self.label.text = Value;
        self.paramCode = Code;
        self.paramValue = Value;
    }
}

-(NSString *)getCode{
    return paramCode;
}

-(void)dealloc{
    delegate  = nil;
    [label release];
    [icon release];
    [paramCode release];
    [paramValue release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
