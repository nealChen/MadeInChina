//
//  MICCommandProvider.h
//  MadeInChina
//
//  Created by mac on 13-11-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICCommandProviderProtocol.h"

#define MIC_Block_Help_Begin ^{
#define MIC_Block_Help_Begin_OBJ ^(id obj){
#define MIC_Block_Help_End };

@interface MICCommandProvider : NSObject <MICCommandProviderProtocol>

@end
