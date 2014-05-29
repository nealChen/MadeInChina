//
//  NSURL+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "NSURL+MadeInChina.h"
#import "NSDictionary+MadeInChina.h"

@implementation NSURL (MadeInChina)

+ (id)URLWithFormat:(NSString *)format, ... {
	va_list arguments;
    va_start(arguments, format);
	NSString *string = MIC_AUTORELEASE([[NSString alloc] initWithFormat:format arguments:arguments]);
	va_end(arguments);
	
	return [NSURL URLWithString:string];
}


- (NSDictionary *)queryDictionary {
    return [NSDictionary dictionaryWithFormEncodedString:self.query];
}

@end
