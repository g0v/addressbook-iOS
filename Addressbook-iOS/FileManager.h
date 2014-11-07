//
//  FileManager.h
//  Addressbook-iOS
//
//  Created by allenlin on 11/7/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "PopoloPerson.h"
#import "PopoloOrganization.h"

static NSString * const kPeopleFilePathKey = @"kPeopleDictionaryKey";
static NSString * const kOrganizationFilePathKey = @"kOrganizationDictionaryKey";



@interface FileManager : NSObject


#pragma mark - IDs
- (NSArray *)readPeopleIDs;
- (NSArray *)readOrganizationsIDs;

- (void)writePersonID:(NSString *)identifier;
- (void)writeOrganizationID:(NSString *)identifier;

#pragma mark - JSON model
- (NSArray *)bookmarkedPeople;
- (NSArray *)bookmarkedOrganizations;

- (void)bookmarkWithPerson:(PopoloPerson *)person;
- (void)bookmarkWithOrganization:(PopoloOrganization *)organization;

+(instancetype)sharedInstance;
@end
