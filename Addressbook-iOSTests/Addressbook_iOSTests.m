//
//  Addressbook_iOSTests.m
//  Addressbook-iOSTests
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "G0VAddressbookClient.h"

@interface Addressbook_iOSTests : XCTestCase

@end

@implementation Addressbook_iOSTests

- (void)setUp
{
    [super setUp];
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
        NSLog(@"I am in loop 0.2s");
	}
}

@end
