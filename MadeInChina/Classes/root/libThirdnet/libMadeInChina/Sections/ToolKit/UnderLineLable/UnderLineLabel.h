//
//  UnderLineLabel.h
//  CustomLabelWithUnderLine
//
//  Created by liuweizhen on 13-4-17.
//  Copyright (c) 2013年 WeiZhen_Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *    使用方法
 UnderLineLabel *label = [[UnderLineLabel alloc] initWithFrame:CGRectMake(50, 200, 300, 30)];
 [label setBackgroundColor:[UIColor clearColor]];
 // [label setBackgroundColor:[UIColor yellowColor]];
 [label setTextColor:[UIColor blueColor]];
 [label setBackgroundColor:[UIColor yellowColor]];
 label.highlightedColor = [UIColor redColor];
 label.shouldUnderline = YES;
 
 
 [label setText:str andCenter:CGPointMake(200, 240)];
 [label addTarget:self action:@selector(labelClicked)];
 [self.view addSubview:label];
 [label release];
 
 
 
 UIImage *image = [UIImage imageNamed:@"ic_drop_down_arrow.png"];
 UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMinY(label.frame), image.size.width, image.size.height)];
 [button setImage:image forState:UIControlStateNormal];
 [self.view addSubview:button];
 [button addTarget:self action:@selector(labelClicked) forControlEvents:UIControlEventTouchUpInside];
 [button release];
 
 
 UnderLineLabel *label_2 = [[UnderLineLabel alloc] initWithFrame:CGRectMake(20, 300, 200, 30)];
 [label_2 setBackgroundColor:[UIColor purpleColor]];
 [self.view addSubview:label_2];
 [label_2 setText:@"Test normal label" ];
 [label_2 release];
 */
@interface UnderLineLabel : UILabel
{
    UIControl *_actionView;
    UIColor *_highlightedColor;
    BOOL _shouldUnderline;
}

@property (nonatomic, retain) UIColor *highlightedColor;

@property (nonatomic, assign) BOOL shouldUnderline;

- (void)setText:(NSString *)text andCenter:(CGPoint)center;
- (void)addTarget:(id)target action:(SEL)action;
@end
 