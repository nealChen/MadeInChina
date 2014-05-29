//
//  MICRelayCommand.m
//  MadeInChina
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICRelayCommand.h"

@interface MICRelayCommand()

//判断是否能执行
@property (copy) CanExeculeBlock rc_can_execute_block;
//执行的命令
@property (copy) ExeculeBlock rc_execute_block;

@end

@implementation MICRelayCommand

- (void)dealloc
{
//    [self unregisterFromNotifications];
//	[self unregisterFromKVO];
#if !__has_feature(objc_arc)
	
#if NS_BLOCKS_AVAILABLE
	[_rc_can_execute_block release];
    [_rc_execute_block release];
#endif
    
	[super dealloc];
#endif
}

-(id)initWithAction:(ExeculeBlock)execute_block{
    
    return [self initWithAction:execute_block andCanExecute:NULL];

}

-(id)initWithAction:(ExeculeBlock)execute_block andCanExecute:(CanExeculeBlock)can_execule_block{
    NSAssert(execute_block, @"execute must not be NULL.");
    
    self = [super init];
    if (self) {
        self.rc_execute_block = execute_block;
        
        self.rc_can_execute_block = can_execule_block;
    }
    return self;
}

-(BOOL)CanExecule:(id)paramter{
    return _rc_can_execute_block == NULL ? true : _rc_can_execute_block(paramter);
}

-(int)Execule:(id)parameter{
    
    if (![self CanExecule:parameter]) {
        return MIC_COMMAND_EXECUTE_NOT_ALLOW;
    }
    
    if (!_rc_execute_block) {
        return MIC_COMMAND_EXECUTE_FAILE;
    }
    
    return _rc_execute_block(parameter);
    
    return MIC_COMMAND_EXECUTE_SUCCESS;
    
}

@end
