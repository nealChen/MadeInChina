//
//  MICCommandProvider.m
//  MadeInChina
//
//  Created by mac on 13-11-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICCommandProvider.h"

@implementation MICCommandProvider

- (CanExeculeBlock)commandCanExeculeBlock{
    
    return
    
    MIC_Block_Help_Begin_OBJ
    
    return YES;
    
    MIC_Block_Help_End
}

- (ExeculeBlock)commandExeculeBlock{
    
    return
    
    MIC_Block_Help_Begin_OBJ
    
    return 0;
    
    MIC_Block_Help_End
    
}

@end
