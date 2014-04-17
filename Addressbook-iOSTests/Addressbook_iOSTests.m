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

- (void)testOrgs
{
    __block BOOL looping = YES;

    [[[G0VAddressbookClient sharedClient] fetchOrganizations] continueWithBlock:^id(BFTask *task) {
        looping = NO;
        XCTAssertNil(task.error, @"There should not be any error.");
        XCTAssertNotNil(task.result, @"There should had result.");

        NSArray *popoloOrgs = task.result;
        for (NSDictionary *onePopolo in popoloOrgs) {

            NSString *identifierOfOnePopolo = [onePopolo valueForKeyPath:@"id"];
            XCTAssertNotNil(identifierOfOnePopolo, @"This must had value.");

            NSString *name = [onePopolo valueForKeyPath:@"name"];
            XCTAssertNotNil(name, @"This should had name.");

            // got identifiers
            NSLog(@"identifiers: %@", [onePopolo valueForKeyPath:@"identifiers.identifier"]);

            // got contact_details
            NSLog(@"Contact details: %@", [onePopolo valueForKeyPath:@"contact_details.value"]);
        }
        return nil;
    }];

    while (looping) {
		[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
	}
}

@end
