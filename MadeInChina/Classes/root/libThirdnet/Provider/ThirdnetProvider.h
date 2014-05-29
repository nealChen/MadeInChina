//
//  ThirdnetProvider.h
//  BusMapII
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MICNetwork.h"

@interface ThirdnetProvider : NSObject <MICNetworkDelegate>

AS_SINGLETON(ThirdnetProvider);


@end
