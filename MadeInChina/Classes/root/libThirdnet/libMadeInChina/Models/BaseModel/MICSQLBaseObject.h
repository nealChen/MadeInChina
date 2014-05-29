//
//  JXTIISQLBaseObject.h
//  JiaXingTrafficII
//
//  Created by mac on 13-10-10.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "SQLitePersistentObject.h"

@interface MICSQLBaseObject : SQLitePersistentObject

@property (nonatomic,assign)int objId;  //
@property (nonatomic,retain)NSDate* createDate;     //创建时间
@property (nonatomic,retain)NSDate* lastDate;           //最后的使用时间
@property (nonatomic,assign)NSUInteger count;       //使用次数
@property (nonatomic,assign)BOOL isHidden;          //是否隐藏
@property (nonatomic,retain)NSString* groupName;    //分组名称

@end
