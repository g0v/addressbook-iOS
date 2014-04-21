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
    NSArray *popoloOrgs = result;
    NSLog(@"result.count: %lu", popoloOrgs.count);

    for (NSDictionary *onePopolo in popoloOrgs) {

        NSString *identifierOfOnePopolo = [onePopolo valueForKeyPath:@"id"];
        XCTAssertNotNil(identifierOfOnePopolo, @"This must had value.");

        NSString *name = [onePopolo valueForKeyPath:@"name"];
        XCTAssertNotNil(name, @"This should had name.");
        NSLog(@"name:%@", name);

        XCTAssertNotNil([onePopolo valueForKeyPath:@"id"], @"This should had id.");
    }
}

- (void)checkResultWithTask:(BFTask *)task
{
    XCTAssertNil(task.error, @"There should not be any error.");
    XCTAssertNotNil(task.result, @"There should had result.");

    [self checkResult:task.result];
}

- (void)testOrgs
{
    __block BOOL looping = YES;

    [[[G0VAddressbookClient sharedClient] fetchOrganizations] continueWithBlock:^id(BFTask *task) {
        looping = NO;
        [self checkResultWithTask:task];
        return nil;
    }];

    while (looping) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
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

    [[[G0VAddressbookClient sharedClient] fetchPersonsWithMatchingString:matchesString] continueWithBlock:^id(BFTask *task) {
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
            // append to |results|
            [results addObjectsFromArray:task.result];

            return [[G0VAddressbookClient sharedClient] fetchPersonsWithMatchingString:matchesString];
        }

        // no |task.result| should had error
        [self checkResultWithTask:task];
        return nil;
    }] continueWithBlock:^id(BFTask *task) {
        looping = NO;

        if (task.result) {
            // append to |results|
            [results addObjectsFromArray:task.result];

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

@end
