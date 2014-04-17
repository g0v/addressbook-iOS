//
//  G0VAddressbookClient.m
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "G0VAddressbookClient.h"

@interface G0VABTaskCompletionSource : BFTaskCompletionSource
+ (G0VABTaskCompletionSource *)taskCompletionSource;
@property (strong, nonatomic) NSURLSessionTask *connectionTask;
@end

@implementation G0VABTaskCompletionSource

+ (G0VABTaskCompletionSource *)taskCompletionSource
{
	return [[G0VABTaskCompletionSource alloc] init];
}

- (void)dealloc
{
	[self.connectionTask cancel];
	self.connectionTask = nil;
}

- (void)cancel
{
	[self.connectionTask cancel];
	[super cancel];
}

@end

@implementation G0VAddressbookClient

+ (NSString *)version
{
    return @"0.1.0";
}

+ (instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    static G0VAddressbookClient *shareClient;
    dispatch_once(&onceToken, ^{
        shareClient = [[G0VAddressbookClient alloc] init];
    });
    return shareClient;
}

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:@"http://pgrest.io/hychen/api.addressbook/v0/"]];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
		self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (BFTask *)_taskWithPath:(NSString *)inPath
{
	G0VABTaskCompletionSource *source = [G0VABTaskCompletionSource taskCompletionSource];
	source.connectionTask = [self GET:inPath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		if (responseObject) {
            NSArray *entries = [responseObject objectForKey:@"entries"];
            [source setResult:entries];
		}
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[source setError:error];
	}];
	return source.task;
}

@end

#pragma mark - Organization

@implementation G0VAddressbookClient (Organization)

- (BFTask *)fetchOrganizations
{
    return [self _taskWithPath:@"collections/organizations"];
}

@end
