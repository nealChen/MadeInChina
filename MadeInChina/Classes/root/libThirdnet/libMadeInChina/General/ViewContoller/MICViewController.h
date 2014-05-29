//
//  MICViewController.h
//  MadeInChina
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/*!
 @header
 @abstract MICViewController
 */

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UIViewController+MadeInChina.h"

///完成操作
typedef void (^MICCompletionBlock)(void);

/*!
 @class
 @abstract MICViewController父类.
 @discussion 所有的ViewController都应该继承该类.
 */
@interface MICViewController : UIViewController<MBProgressHUDDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>
/*!
 @property
 @abstract 标识.
 */
@property (nonatomic,assign)NSInteger tag;
/*!
 @property
 @abstract 浮动层.
 */
@property(nonatomic,MIC_STRONG)MBProgressHUD *HUD;

#pragma mark Active(主动的)

/*!
 @method
 @abstract 弹出一个等待Tosat消息
 @discussion 效果为: 菊花＋请稍等
 */
- (void)showWaitingToHUD;

/*!
 @method
 @abstract 弹出一个等待Tosat消息
 @param completionBlock 当显示完成
 @discussion 效果为: 菊花＋请稍等
 */
- (void)showStrongWaitingToHUD:(MICCompletionBlock)completionBlock;

/*!
 @method
 @abstract 弹出一个Tosat消息,显示两秒
 @discussion 需要提供显示的模式 MBProgressHUDMode 
 @param message 消息内容 
 @param mode 模式
 */
- (void)showTosat:(NSString*)message andMode:(MBProgressHUDMode)mode;
/*!
 @method
 @abstract 弹出一个Tosat消息,显示两秒
 @discussion 根据提供的消息内容可以帮助显示一些提示消息
 @param message 消息内容
 */
- (void)showTosat:(NSString*)message;

/*!
 @method
 @abstract 移除HUD
 @discussion 该方法与Tosat方法或者HUD方法结合使用(值得注意的是该方法有点迟钝,可能你达不到你想要的结果)
 */
- (void)removeHUD;

/*!
 @method
 @abstract 移除HUD
 @param completionBlock 当操作完成
 @discussion 该方法是removeHUD的升级版本
 */
- (void)removeHUD:(MICCompletionBlock)completionBlock;

/*!
 @method
 @abstract 弹出Dialog消息框
 @discussion 根据提供的消息内容,弹出Dialog形式的消息框
 @param message 消息内容
 */
- (void)showMessageBox:(NSString*)title Message:(NSString*)message;

#pragma mark Passive（被动的）

/*!
 @method
 @abstract 重置导航按钮
 @discussion 当viewDidLoad执行的时候会调用该方法,该方法的默认实现为空,如果有需要可以重写该方法；
 参考例子：
 - (void)resetNavigationbarItemButton
 {
 UIImage *ima=[UIImage imageNamed:@"MIC_Back_Image.png"];
 UIButton *BackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 40, 40)];
 [BackBtn setImage:ima forState:UIControlStateNormal];
 [BackBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
 UIBarButtonItem *BackBarBtn = [[UIBarButtonItem alloc] initWithCustomView:BackBtn];
 self.navigationItem.leftBarButtonItem = BackBarBtn;
 [BackBtn release];
 [BackBarBtn release];
 }
 */
- (void)resetNavigationbarItemButton;

/*!
 @method
 @abstract 推出页面
 @discussion 从self.navigationController推出一个ViewController
 */
- (void)popViewController;

/*!
 @method
 @abstract 视图触摸事件
 @param tapGr 手势信息
 @discussion 该方法是一个被动方法,当在屏幕上触摸空白区域时执行该方法
 */
- (void)viewTapped:(UITapGestureRecognizer*)tapGr DEPRECATED_ATTRIBUTE;

/*!
 @method
 @abstract 视图适配
 @discussion 初始化时，并且设备为4寸屏时调用
 */
-(void)resizeSubViews DEPRECATED_ATTRIBUTE;

/*!
 @method
 @abstract 视图适配
 @param windowSize 窗口的尺寸
 @param osVersion 系统版本
 @discussion 适配通过View的尺寸
 */
-(void)resizeSubViewsByScreenSize:(CGSize)windowSize andOSVersion:(NSString*)osVersion;
/*!
 @method
 @abstract 视图适配
 @param screenMode 屏幕大小
 @param osVersion 系统版本
 @discussion 适配通过View的尺寸
 */
-(void)resizeSubViewsByScreenMode:(UIScreenMode*)screenMode andOSVersion:(NSString *)osVersion;

/*!
 @method
 @abstract 视图适配
 @param viewSize 视图尺寸
 @discussion 适配通过View的尺寸
 */
-(void)resizeSubViewsByViewSize:(CGSize)viewSize andOSVersion:(NSString*)version;

@end

extern NSString *const CATransitionTypeCube;
extern NSString *const CATransitionTypeMoveIn;
extern NSString *const CATransitionTypeReveal;
extern NSString *const CATransitionTypeFade;
extern NSString *const CATransitionTypePageCurl;
extern NSString *const CATransitionTypePageUnCurl;
DEPRECATED_MSG_ATTRIBUTE("private property")
extern NSString *const CATransitionTypeSuckEffect;
DEPRECATED_MSG_ATTRIBUTE("private property")
extern NSString *const CATransitionTypeRippleEffect;
extern NSString *const CATransitionTypeOglFlip;

/*!
 过渡效果
 */
@interface MICViewController (Transition)

///提供对象的过渡方法
- (CATransition *)viewWillDisappearWithAnimated;
- (CATransition *)viewWillAppearWithAnimated;

/*!
 预设动画工厂
 @param name kCAMediaTimingFunctionEaseInEaseOut
 @param transitionFromtype 
 */
- (CATransition *)transitionFactoryWithTransitionType:(NSString *)transitionType
                                     functionWithName:(NSString *)name
                                   transitionFromType:(NSString *)transitionFromType;

@end
