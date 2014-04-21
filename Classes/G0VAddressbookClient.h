//
//  G0VAddressbookClient.h
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "AFNetworking.h"
#import "Bolts.h"
// model
#import "PopoloOrganizationModel.h"
#import "PopoloPersonModel.h"

@interface PagingModel : JSONModel
@property (assign, nonatomic) NSUInteger resultCount;
@property (assign, nonatomic) NSUInteger offset;
@property (assign, nonatomic) NSUInteger pageLength;
@end

@interface PgRestResult : JSONModel
@property (strong, nonatomic) PagingModel *paging;
@property (strong, nonatomic) NSArray<PopoloOrganizationModel, PopoloPersonModel> *entries;
@property (strong, nonatomic) NSString<Optional> *query;
@end

#pragma mark -

@interface G0VAddressbookClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@interface G0VAddressbookClient (Organization)

- (BFTask *)fetchOrganizations;

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString;

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString startAtOffset:(long)offset pageLength:(long)pageLength;

@end

@interface G0VAddressbookClient (Person)

- (BFTask *)fetchPersons;

- (BFTask *)fetchPersonsWithMatchesString:(NSString *)matchesString;

- (BFTask *)fetchPersonsWithMatchesString:(NSString *)matchesString startAtOffset:(long)offset pageLength:(long)pageLength;

@end
