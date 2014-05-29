//
//  MICCommandProtocol.h
//  MadeInChina
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICTask.h"

/*!
 执行错误
 */
#define MIC_COMMAND_EXECUTE_FAILE -1
/*!
 不允许执行
 */
#define MIC_COMMAND_EXECUTE_NOT_ALLOW -2
/*!
 执行成功
 */
#define MIC_COMMAND_EXECUTE_SUCCESS 0
/*!
 命令被取消
 */
#define MIC_COMMAND_EXECUTE_CANCELLED 1
/*!
 命令无效
 */
#define MIC_COMMAND_EXECUTE_INVALID 2


#if NS_BLOCKS_AVAILABLE

/*!
 返回代码段
 */
//typedef int (^ResultBlock)(id paramter);

/*!
 判断是否可以运行
 */
typedef BOOL (^CanExeculeBlock)(id paramter);

/*!
 运行代码段
 */
//typedef int (^ExeculeBlock)(id paramter,ResultBlock Result_block);

/*!
 运行代码段
 */
//typedef int (^ExeculeBlock_IndexPath)(id paramter,NSIndexPath *indexPath,ResultBlock Result_block);

#else
#error NS_BLOCKS_AVAILABLE
#endif

@protocol MICCommandProtocol <NSObject>

/*!
 是否可以执行
 paramter 参数
 */
-(BOOL)CanExecule:(id)paramter;
/*!
 执行命令
 paramter 参数
 */
-(int)Execule:(id)parameter;

///*!
// 执行命令
// paramter 参数
// complete_block 当命令完成时调用
// */
//-(int)Execule:(id)parameter completeBlock:(ResultBlock)complete_block;
//
///*!
// 执行命令
// paramter 参数
// indexPath 请求编号
// complete_block 当命令完成时调用
// */
//-(int)Execule:(id)parameter andIndexPath:(NSIndexPath*)indexPath completeBlock:(ResultBlock)complete_block;

@end
