//
//  G0VAddressbookClient.h
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "AFNetworking.h"
#import "Bolts.h"
// model
#import "PopoloOrganization.h"
#import "PopoloPerson.h"

@interface PagingModel : JSONModel
@property (assign, nonatomic) NSUInteger resultCount;
@property (assign, nonatomic) NSUInteger offset;
@property (assign, nonatomic) NSUInteger pageLength;
@end

@interface PgRestPersonResult : JSONModel
@property (strong, nonatomic) PagingModel *paging;
@property (strong, nonatomic) NSArray<PopoloPerson> *entries;
@property (strong, nonatomic) NSString<Optional> *query;
@end

@interface PgRestOrganizationResult : JSONModel
@property (strong, nonatomic) PagingModel *paging;
@property (strong, nonatomic) NSArray<PopoloOrganization> *entries;
@property (strong, nonatomic) NSString<Optional> *query;
@end

#pragma mark -

@interface G0VAddressbookClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@interface G0VAddressbookClient (Organization)

- (BFTask *)fetchOrganizationsWithIDString:(NSString *)idString;

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString;

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString startAtOffset:(long)offset pageLength:(long)pageLength;

@end

@interface G0VAddressbookClient (Person)

- (BFTask *)fetchPersonsWithMatchesIDString:(NSString *)idString;

- (BFTask *)fetchPersonsWithMatchesString:(NSString *)matchesString;

- (BFTask *)fetchPersonsWithMatchesString:(NSString *)matchesString startAtOffset:(long)offset pageLength:(long)pageLength;

@end
