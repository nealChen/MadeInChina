//
//  UIApplication+MadeInChina.m
//  MadeInChina
//
//  Created by mac on 13-11-18.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "UIApplication+MadeInChina.h"
#import "OpenUDID.h"
#import "MICConfig.h"

@implementation UIApplication (MadeInChina)

- (BOOL)isPirated {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"] != nil;
}


- (void)setNetworkActivity:(BOOL)inProgress {
	// Ensure we're on the main thread
	if ([NSThread isMainThread] == NO) {
		[self performSelectorOnMainThread:@selector(_setNetworkActivityWithNumber:) withObject:[NSNumber numberWithBool:inProgress] waitUntilDone:NO];
		return;
	}
	
	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_setNetworkActivityIndicatorHidden) object:nil];
	
	if (inProgress == YES) {
		if (self.networkActivityIndicatorVisible == NO) {
			self.networkActivityIndicatorVisible = inProgress;
		}
	} else {
		[self performSelector:@selector(_setNetworkActivityIndicatorHidden) withObject:nil afterDelay:0.3];
	}
}


- (NSURL *)documentsDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)cachesDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)downloadsDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDownloadsDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)libraryDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)applicationSupportDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
}

+(NSString*)getApplacationId{
    
    static NSString *appId = nil;
    
    if (!appId) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        appId = [ud stringForKey:MIC_APPLICATION_ID_KEY];
        if (!appId) {
            appId = [OpenUDID value];
            [ud setObject:appId forKey:MIC_APPLICATION_ID_KEY];
            [ud synchronize];
        }
    }
    
    return appId;
}

-(void)tel:(NSString *)callNum whetherToReturn:(BOOL)wtr{

    NSLog(@"%@",callNum);
    
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",callNum]];
    
    if (wtr) {
        UIWebView*callWebview =MIC_AUTORELEASE([[UIWebView alloc] init]);
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        [[[self.windows lastObject] view] addSubview:callWebview];
//        [[[[[UIApplication sharedApplication]windows]lastObject] view]  addSubview:callWebview];

    }else{
//        [[UIApplication sharedApplication]openURL:telURL];
        [self openURL:telURL];
    }
}

@end


@interface UIApplication (MSPrivateAdditions)
- (void)_setNetworkActivityWithNumber:(NSNumber *)number;
- (void)_setNetworkActivityIndicatorHidden;
@end

@implementation UIApplication (MSPrivateAdditions)

- (void)_setNetworkActivityWithNumber:(NSNumber *)number {
	[self setNetworkActivity:[number boolValue]];
}


- (void)_setNetworkActivityIndicatorHidden {
	self.networkActivityIndicatorVisible = NO;
}


@end
