//
//  MICMapAndNetworkViewController.m
//  MadeInChina
//
//  Created by mac on 13-9-13.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MICMapAndNetworkViewController.h"

@interface MICMapAndNetworkViewController ()

@end

@implementation MICMapAndNetworkViewController
@synthesize network;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    network = [MICNetwork sharedMICNetwork];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// These are the default delegate methods for request status
// You can use different ones by setting didStartSelector / didFinishSelector / didFailSelector
- (void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"requestStarted");
}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
    
}
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL{
    
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    
    NSLog(@"%d  !! %@",error.code,error.localizedDescription);
    
    
    
    //    NSString *responseString = [request responseString];
    //    NSString *responseStatusMessgae = [request responseStatusMessage];
    //    NSDictionary *DataAchieved=[responseString objectFromJSONString];
    //    NSLog(@"%@",[DataAchieved objectForKey:@"Message"]);
    
    [self someProblemInNetwork];
}
-(void)someProblemInNetwork
{
    if ([self.view window]==nil) {
        return;
    }
    [self performSelectorOnMainThread:@selector(removeHUD) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(showAllertFail) withObject:nil waitUntilDone:YES];
}
-(void)showAllertFail
{
    [self showMessageBox:nil Message:@"网络请求出错"];
}

- (void)requestRedirected:(ASIHTTPRequest *)request{
    
}

// When a delegate implements this method, it is expected to process all incoming data itself
// This means that responseData / responseString / downloadDestinationPath etc are ignored
// You can have the request call a different method by setting didReceiveDataSelector
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data{
    
}

// If a delegate implements one of these, it will be asked to supply credentials when none are available
// The delegate can then either restart the request ([request retryUsingSuppliedCredentials]) once credentials have been set
// or cancel it ([request cancelAuthentication])
- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request{
    
}
- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request{
    
}


@end
