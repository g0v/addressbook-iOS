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

@implementation PagingModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:
            @{@"count" : @"resultCount",
              @"sk" : @"offset",
              @"l" : @"pageLength"
              }];
}

@end

@implementation PgRestResult
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
        shareClient = [[G0VAddressbookClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://127.0.0.1:3000/collections/"]];
    });
    return shareClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
		self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (BFTask *)_taskWithPath:(NSString *)inPath parameters:(NSDictionary *)parameters
{
	G0VABTaskCompletionSource *source = [G0VABTaskCompletionSource taskCompletionSource];
	source.connectionTask = [self GET:inPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
		if (responseObject) {
            NSError *jsonError = nil;
            PgRestResult *result = [[PgRestResult alloc] initWithDictionary:responseObject error:&jsonError];
            if (jsonError) {
                [source setError:jsonError];
            } else {
                [source setResult:result];
            }
		}
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[source setError:error];
	}];
	return source.task;
}

- (NSDictionary *)_paramentersWithMatchesName:(NSString *)matchesName startAtOffset:(long)offset pageLength:(long)pageLength
{
    NSString *quretyStringWithMatchingString = [NSString stringWithFormat:@"{\"name\":{\"$matches\":\"%@\"}}", matchesName];
    NSMutableDictionary *paramenters = [NSMutableDictionary dictionaryWithDictionary:@{@"q":quretyStringWithMatchingString}];

    if (offset >= 0) {
        [paramenters setValue:@(offset) forKey:kOffset];
    }
    if (pageLength > 0) {
        [paramenters setValue:@(pageLength) forKey:kLength];
    }
    return paramenters;
}

@end

#pragma mark - Organization

@implementation G0VAddressbookClient (Organization)

- (BFTask *)fetchOrganizations
{
    return [self _taskWithPath:@"organizations" parameters:nil];
}

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString
{
    return [self fetchOrganizationsWithMatchesString:matchesString startAtOffset:0 pageLength:0];
}

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString startAtOffset:(long)offset pageLength:(long)pageLength
{
    NSDictionary *paramenters = [self _paramentersWithMatchesName:matchesString startAtOffset:offset pageLength:pageLength];
    return [self _taskWithPath:@"organizations" parameters:paramenters];
}

@end

#pragma mark - Person

@implementation G0VAddressbookClient (Person)

- (BFTask *)fetchPersons
{
    return [self _taskWithPath:@"person" parameters:nil];
}

- (BFTask *)fetchPersonsWithMatchesString:(NSString *)matchesString
{
    return [self fetchOrganizationsWithMatchesString:matchesString startAtOffset:0 pageLength:0];
}

- (BFTask *)fetchPersonsWithMatchesString:(NSString *)matchesString startAtOffset:(long)offset pageLength:(long)pageLength
{
    NSDictionary *paramenters = [self _paramentersWithMatchesName:matchesString startAtOffset:offset pageLength:pageLength];
    return [self _taskWithPath:@"person" parameters:paramenters];
}

@end
