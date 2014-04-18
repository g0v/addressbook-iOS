//
//  G0VAddressbookClient.m
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "G0VAddressbookClient.h"

static NSString *kPaging = @"paging";
static NSString *kEntries = @"entries";

static NSString *kCount = @"count";
static NSString *kOffset = @"sk";
static NSString *kLength = @"l";

@interface NSDictionary (Paging)
- (BOOL)haveMorePage;
@end

@implementation NSDictionary (Paging)

- (long)count
{
    return [[self valueForKeyPath:kCount] longValue];
}

- (long)pageLength
{
    return 2000;
    return [[self valueForKeyPath:kLength] longValue];
}

- (long)offset
{
    return [[self valueForKeyPath:kOffset] longValue];
}

- (BOOL)haveMorePage
{
    return self.offset + self.pageLength < self.count;
}

@end

#pragma mark -

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

#pragma mark - G0VAddressbookClient

@implementation G0VAddressbookClient

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
    self = [super initWithBaseURL:[NSURL URLWithString:@"http://pgrest.io/hychen/api.addressbook/v0/collections/"]];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
		self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (BFTask *)_taskWithPath:(NSString *)inPath parameters:(NSDictionary *)parameters lastEntries:(NSArray *)lastEntries
{
	G0VABTaskCompletionSource *source = [G0VABTaskCompletionSource taskCompletionSource];
	source.connectionTask = [self GET:inPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
		if (responseObject) {
            NSDictionary *paging = [responseObject objectForKey:kPaging];

            NSArray *entries = [responseObject objectForKey:kEntries];

            if (paging.haveMorePage) {
                NSNumber *newOffset = [NSNumber numberWithLongLong:paging.offset + paging.pageLength];
                NSLog(@"newOffset: %@ last entries: %d entries: %d", newOffset, lastEntries.count, entries.count);
                NSArray *newEntries = [lastEntries arrayByAddingObjectsFromArray:entries];

                [[self _taskWithPath:inPath
                          parameters:@{ kOffset : newOffset, kLength : @(paging.pageLength) }
                         lastEntries:newEntries] continueWithBlock:^id(BFTask *task) {
                    return nil;
                }];
            } else {
                [source setResult:entries];
            }
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
    return [self _taskWithPath:@"organizations" parameters:nil lastEntries:nil];
}

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString
{
    NSString *quretyStringWithMatchingString = [NSString stringWithFormat:@"{\"name\":{\"$matches\":\"%@\"}}", matchesString];
    return [self _taskWithPath:@"organizations" parameters:@{@"q":quretyStringWithMatchingString} lastEntries:nil];
}

@end
