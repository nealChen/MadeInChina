//
//  HTMapForChoosingViewController.h
//  HzTraffic
//
//  Created by swkj001152 on 14-3-23.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MICSimpleMapViewController.h"

@protocol MICMapForChoosingViewControllerDelegate;

@interface MICMapForChoosingViewController : MICSimpleMapViewController
///允许多选
@property (assign,nonatomic)BOOL allowsMultipleSelection;
///视图显示后 是否显示显示当前位置
@property (assign,nonatomic)BOOL moveToCurrentLocation;

@property (MIC_WEAK,nonatomic)id<MICMapForChoosingViewControllerDelegate> mapChooseDelegate;

@end


@protocol MICMapForChoosingViewControllerDelegate <NSObject>

///将要添加标注
-(BOOL)mapForChoosing:(MICMapForChoosingViewController*)viewController shouldAddAnnotation:(id<BMKAnnotation>)annotation;
///标注样式
-(BMKAnnotationView *)mapForChoosing:(MICMapForChoosingViewController*)viewController viewForAnnotation:(id<BMKAnnotation>)annotation;
///选择标注
-(void)mapForChoosing:(MICMapForChoosingViewController*)viewController didSelectAnnotationView:(BMKAnnotationView *)view;

@end
