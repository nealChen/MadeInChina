//
//  MICLetter.h
//  MadeInChina
//
//  Created by mac on 13-11-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
/*!
 返回代码段
 */
typedef int (^ResultBlock)(id paramter);

/*!
 运行代码段
 */
typedef int (^ExeculeBlock)(id paramter);
//typedef int (^ExeculeBlock)(id paramter,ResultBlock Result_block);

@interface MICTask : NSObject
/*!
 任务名
 */
@property (copy,nonatomic)NSString *name;
/*!
 任务编号
 */
@property (retain,nonatomic)NSIndexPath *indexPath;
/*!
 任务的必需品
 */
@property (retain,nonatomic)id supply;
/*!
 任务内容
 */
//@property (copy,nonatomic)ExeculeBlock task_block DEPRECATED_ATTRIBUTE;
/*!
 如何完成任务
 */
@property (copy,nonatomic)ResultBlock complete_block;

@end
