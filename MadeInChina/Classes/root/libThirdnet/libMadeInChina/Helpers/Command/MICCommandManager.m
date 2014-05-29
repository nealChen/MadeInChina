//
//  MICCommandManager.m
//  MadeInChina
//
//  Created by mac on 13-11-6.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICCommandManager.h"
#import "MICCommandProtocol.h"
#import "MICRelayCommand.h"
#import "MICCommandProviderProtocol.h"
#import "MICCommandStore.h"

static MICCommandManager *manager;
int cm_section = 0;
int cm_index = 0;

@interface MICCommandManager()

@property (nonatomic,MIC_STRONG)NSMutableDictionary *dic_commands;

@property (nonatomic,MIC_STRONG)NSMutableDictionary *dic_call_block;

@property (nonatomic,MIC_STRONG)NSMutableDictionary *dic_acticity_indexPath;

@end

@implementation MICCommandManager

+ (instancetype)sharedCommandManager{
    if (!manager) {
        manager = [[MICCommandManager alloc]init];
    }
    return manager;
}

- (void)dealloc
{
    self.dic_acticity_indexPath = nil;
    self.dic_call_block = nil;
    self.dic_commands = nil;
#if ! __has_feature(objc_arc)
    //#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
    [super dealloc];
#endif
}

- (id)init
{
    self = [super init];
    if (self) {
        self.dic_commands = [NSMutableDictionary dictionary];
        self.dic_call_block = [NSMutableDictionary dictionary];
        self.dic_acticity_indexPath = [NSMutableDictionary dictionary];
    }
    return self;
}

- (int)executeCommandProviderWithName:(NSString*)command_name withObject:(id)obj completeBlock:(ResultBlock)result_block{
    
    NSAssert(command_name, @"command_name must not be nil.");
    
    id<MICCommandProtocol> command = [self.dic_commands objectForKey:command_name];
    if (!command) {
        
        NSString *commandProviderClassName = [NSString stringWithFormat:MIC_COMMAND_FOR_STORE,command_name];
        Class commandProviderClass = NSClassFromString(commandProviderClassName);
        NSAssert1(commandProviderClass, @"%@ can't find.", commandProviderClassName);
        id<MICCommandProviderProtocol> commandProvider = [[commandProviderClass alloc]init];

        
        command = [[MICRelayCommand alloc]initWithAction:[commandProvider commandExeculeBlock] andCanExecute:[commandProvider commandCanExeculeBlock]];

        
        [self.dic_commands setObject:command forKey:command_name];
    }
    

    int result = MIC_COMMAND_EXECUTE_FAILE;
    if (command) {

        MICTask *t_task = MIC_AUTORELEASE([[MICTask alloc]init]);
        t_task.name = command_name;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cm_index inSection:cm_section];
        [self.dic_acticity_indexPath setObject:indexPath forKey:command_name];
        t_task.indexPath = indexPath;
        t_task.supply = obj;
        t_task.complete_block = ^int(id paramter) {
            
            if (![[self.dic_acticity_indexPath objectForKey:[paramter name]] isEqual:[paramter indexPath]]) {
                return MIC_COMMAND_EXECUTE_INVALID;
            }
            
            return result_block(paramter);
            
        };
        
        result = [command Execule:t_task];

    }
    
    return result;
    
}

@end
