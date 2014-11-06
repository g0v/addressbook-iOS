//
//  AppDelegate.m
//  Addressbook-iOS
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "AppDelegate.h"

#import "AFNetworkActivityIndicatorManager.h"
#import "Crashlytics.h"

#import "OHHTTPStubs.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    [Crashlytics startWithAPIKey:@"aa4bea7059a82c8870fd136c48413ae4cd41082c"];
    
#if DEBUG
    [self _setUpOHHTTPStubs];
#endif
    
    return YES;
}

- (void)_setUpOHHTTPStubs
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.host isEqualToString:@"pgrest.io"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        NSDictionary *jsonHeader = @{@"Content-Type":@"text/json"};
        // Organizations
        if ([request.URL.absoluteString rangeOfString:@"organizations?" options:NSBackwardsSearch].location != NSNotFound) {
            NSString *organizations = OHPathForFileInBundle(@"search_organizations.json", nil);
            return [OHHTTPStubsResponse responseWithFileAtPath:organizations
                                                    statusCode:200
                                                       headers:jsonHeader];
        }
        
        // Person
        if ([request.URL.absoluteString rangeOfString:@"person?" options:NSBackwardsSearch].location != NSNotFound) {
            NSString *person = OHPathForFileInBundle(@"search_person.json", nil);
            return [OHHTTPStubsResponse responseWithFileAtPath:person
                                                    statusCode:200
                                                       headers:jsonHeader];
        }
        
        // Organization ID
        if ([request.URL.absoluteString rangeOfString:@"organizations/1" options:NSBackwardsSearch].location != NSNotFound) {
            NSString *organizations_1 = OHPathForFileInBundle(@"organizations_1.json", nil);
            return [OHHTTPStubsResponse responseWithFileAtPath:organizations_1
                                                    statusCode:200
                                                       headers:jsonHeader];
        }
        // Person ID
        if ([request.URL.absoluteString rangeOfString:@"person/1" options:NSBackwardsSearch].location != NSNotFound) {
            NSString *person_1 = OHPathForFileInBundle(@"person_1.json", nil);
            return [OHHTTPStubsResponse responseWithFileAtPath:person_1
                                                    statusCode:200
                                                       headers:jsonHeader];
        }
        
        // Error
        NSString *error = OHPathForFileInBundle(@"error.json", nil);
        return [OHHTTPStubsResponse responseWithFileAtPath:error
                                                statusCode:404
                                                   headers:jsonHeader];
    }];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
