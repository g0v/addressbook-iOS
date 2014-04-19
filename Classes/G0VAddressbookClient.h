//
//  G0VAddressbookClient.h
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "AFNetworking.h"
#import "Bolts.h"

@interface G0VAddressbookClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

@interface G0VAddressbookClient (Organization)

- (BFTask *)fetchOrganizations;

- (BFTask *)fetchOrganizationsWithMatchesString:(NSString *)matchesString;

@end

@interface G0VAddressbookClient (Person)

- (BFTask *)fetchPersons;

- (BFTask *)fetchPersonsWithMatchingString:(NSString *)matchesString;

@end
