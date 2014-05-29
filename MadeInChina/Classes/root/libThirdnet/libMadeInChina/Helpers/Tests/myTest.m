//
//  myTest.m
//  TestMyFramework
//
//  Created by swkj on 13-12-9.
//  Copyright (c) 2013年 huang. All rights reserved.
//
/*
#import "myTest.h"
#import <objc/runtime.h>
@implementation myTest


- (void)testViewController
{

    unsigned int classesCount = 0;
    
    //获取运行程序所有类
    Class *	classes = objc_copyClassList(&classesCount);

    for (unsigned int ci = 0; ci < classesCount; ci++) {
        Class testClass = classes[ci];
    
//            //获取类名
//            const char * str = class_getName(testClass);
    
        //不响应方法的就跳过
        if ( NO == class_respondsToSelector( testClass, @selector(doesNotRecognizeSelector:) ) )
            continue;
        if ( NO == class_respondsToSelector( testClass, @selector(methodSignatureForSelector:) ) )
            continue;
            
        unsigned int methodsCount = 0;
        //获取指定类的所有方法
        Method *method = class_copyMethodList(testClass, &methodsCount);
        for (unsigned int mi = 0; mi < methodsCount; mi++) {
            //获取方法 以及方法名
            SEL sel = method_getName(method[mi]);
            NSString *mString = NSStringFromSelector(sel);
    
            //判断是否包含thirdNet_test的方法  含有就执行
            if ( [mString rangeOfString:@"thirdNet_test"].location != NSNotFound ) {
                id object=[[testClass alloc] init];
                int x = [mString rangeOfString:@"thirdNet_test"].length;
                NSString *tmp = [mString substringFromIndex:x];
                XCTAssertTrue( [object performSelector:sel withObject:nil], "类%@, 方法TEST(%@)不通过",testClass, tmp);
                [object release];
                }
            }
    }
    free(classes);
    
}


@end
 */
