//
//  Addressbook_iOSTests.m
//  Addressbook-iOSTests
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "G0VAddressbookClient.h"
#import "OHHTTPStubs.h"

@interface Addressbook_iOSTests : XCTestCase

@end

@implementation Addressbook_iOSTests

- (void)setUp
{
    [super setUp];
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

- (void)tearDown
{
    [super tearDown];
}

- (void)checkResult:(id)result
{
    if ([result isKindOfClass:[PgRestOrganizationResult class]]) {
        for (PopoloOrganization *org in ((PgRestOrganizationResult *)result).entries) {
            NSLog(@"org name:%@", org.name);
            XCTAssertNotNil(org.name, @"This should had name.");
            XCTAssertNotNil(org.id, @"This must had value.");
        }
    }

    if ([result isKindOfClass:[PgRestPersonResult class]]) {
        for (PopoloPerson *person in ((PgRestPersonResult *)result).entries) {
            NSLog(@"person name:%@", person.name);
            XCTAssertNotNil(person.name, @"This should had name.");
            XCTAssertNotNil(person.id, @"This must had value.");
        }
    }
}

- (void)checkResultWithTask:(BFTask *)task
{
    XCTAssertNil(task.error, @"There should not be any error.");
    XCTAssertNotNil(task.result, @"There should had result.");

    [self checkResult:task.result];
}

- (void)testOrgsWithMatchesString
{
    NSString *matchesString = @"立法";
    __block BOOL looping = YES;

    [[[G0VAddressbookClient sharedClient] fetchOrganizationsWithMatchesString:matchesString] continueWithBlock:^id(BFTask *task) {
        looping = NO;
        [self checkResultWithTask:task];
        return nil;
    }];

    while (looping) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
}

- (void)testPersonsWithMatchesString
{
    NSString *matchesString = @"張";
    __block BOOL looping = YES;

    [[[G0VAddressbookClient sharedClient] fetchPersonsWithMatchesString:matchesString] continueWithBlock:^id(BFTask *task) {
        looping = NO;
        [self checkResultWithTask:task];
        return nil;
    }];

    while (looping) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
}

- (void)testOrgsAndPersonsWithMatchesString
{
    NSString *matchesString = @"張";
    __block BOOL looping = YES;
    NSMutableArray *results = [NSMutableArray array];

    [[[[G0VAddressbookClient sharedClient] fetchOrganizationsWithMatchesString:matchesString] continueWithBlock:^id(BFTask *task) {
        if (task.result) {
            PgRestOrganizationResult *result = task.result;
            // append to |results|
            [results addObjectsFromArray:result.entries];

            return [[G0VAddressbookClient sharedClient] fetchPersonsWithMatchesString:matchesString];
        }

        // no |task.result| should had error
        [self checkResultWithTask:task];
        return nil;
    }] continueWithBlock:^id(BFTask *task) {
        looping = NO;

        if (task.result) {
            PgRestPersonResult *result = task.result;
            // append to |results|
            [results addObjectsFromArray:result.entries];

            [self checkResult:results];
            return nil;
        }

        // no |task.result| should had error
        [self checkResultWithTask:task];
        return nil;
    }];

    while (looping) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
}

- (void)testFetchOnePersonWithIDString
{
    NSString *idString = @"1";
    __block BOOL looping = YES;

    [[[G0VAddressbookClient sharedClient] fetchPersonsWithMatchesIDString:idString] continueWithBlock:^id(BFTask *task) {
        looping = NO;
        [self checkResultWithTask:task];
        return nil;
    }];

    while (looping) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
}

- (void)testFetchOneOrganizationWithIDString
{
    NSString *idString = @"1";
    __block BOOL looping = YES;

    [[[G0VAddressbookClient sharedClient] fetchOrganizationsWithIDString:idString] continueWithBlock:^id(BFTask *task) {
        looping = NO;
        [self checkResultWithTask:task];
        return nil;
    }];

    while (looping) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
}

@end
