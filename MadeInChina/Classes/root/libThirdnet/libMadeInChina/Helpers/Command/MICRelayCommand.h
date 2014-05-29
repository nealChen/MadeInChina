//
//  MICRelayCommand.h
//  MadeInChina
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICCommandProtocol.h"

@interface MICRelayCommand : NSObject <MICCommandProtocol>

/*!
 @method
 @abstract 初始化MICRelayCommand 使用ExeculeBlock
 @param execute_block 执行的代码块
 @discussion execute_block不能为NULL
 */
-(id)initWithAction:(ExeculeBlock)execute_block;

/*!
 @method
 @abstract 初始化MICRelayCommand 使用ExeculeBlock 和 CanExeculeBlock
 @param execute_block 执行的代码块
 @param can_execule_block 判断的代码块
 @discussion execute_block不能为NULL，can_execule_block不用可以传NULL
 */
-(id)initWithAction:(ExeculeBlock)execute_block andCanExecute:(CanExeculeBlock)can_execule_block;

@end
