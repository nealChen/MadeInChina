//
//  MICCommandProviderProtocol.h
//  MadeInChina
//
//  Created by mac on 13-11-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#ifndef MadeInChina_MICCommandProviderProtocol_h
#define MadeInChina_MICCommandProviderProtocol_h

#import "MICCommandProtocol.h"

@protocol MICCommandProviderProtocol <NSObject>

//- (ResultBlock)commandResultBlock;

- (CanExeculeBlock)commandCanExeculeBlock;

- (ExeculeBlock)commandExeculeBlock;

@end

#endif
