//
//  FileManager.m
//  Addressbook-iOS
//
//  Created by allenlin on 11/7/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

- (NSString *)filePathWithKey:(NSString *)filePathKey
{
    if (!filePathKey) {
        return nil;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filePathKey];
    //save content to the documents directory
    return filePath;
}

- (NSArray *)readPeopleIDs
{
    NSArray *people = nil;
    NSString *path = [self filePathWithKey:kPeopleFilePathKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        people = [[NSArray alloc] initWithContentsOfFile:kPeopleFilePathKey];
    }
    
    return people;
}

- (NSArray *)readOrganizationsIDs
{
    NSArray *organizations = nil;
    NSString *path = [self filePathWithKey:kOrganizationFilePathKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        organizations = [[NSArray alloc] initWithContentsOfFile:kOrganizationFilePathKey];
    }
    
    return organizations;
}

- (void)writePersonID:(NSString *)identifier
{
    NSMutableArray *peopleIDs = nil;
    NSString *filePath = [self filePathWithKey:kPeopleFilePathKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        peopleIDs = [[NSMutableArray alloc] initWithContentsOfFile:kPeopleFilePathKey];
        [peopleIDs addObject:identifier];
    }
    else{
        peopleIDs = [[NSMutableArray alloc] initWithObjects:identifier, nil];
    }

    [peopleIDs writeToFile:filePath atomically:YES];
}

- (void)writeOrganizationID:(NSString *)identifier
{
    NSMutableArray *organizationIDs = nil;
    NSString *filePath = [self filePathWithKey:kOrganizationFilePathKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        organizationIDs = [[NSMutableArray alloc] initWithContentsOfFile:kOrganizationFilePathKey];
        [organizationIDs addObject:identifier];
    }
    else{
        organizationIDs = [[NSMutableArray alloc] initWithObjects:identifier, nil];
    }
    
    [organizationIDs writeToFile:filePath atomically:YES];
}

//- (void)bookmarkWithPerson:(PopoloPerson *)person
//{

//    NSMutableArray *people = nil;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:kPeopleFilePathKey]) {
//        people = [[NSMutableArray alloc] initWithContentsOfFile:kPeopleFilePathKey];
//        [people addObject:person];
//    }
//    else{
//        people = [[NSMutableArray alloc] initWithObjects:person, nil];
//    }
//
//}

//- (void)bookmarkWithOrganization:(PopoloOrganization *)organization
//{
//    NSMutableArray *organizations = nil;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:kOrganizationFilePathKey]) {
//        organizations = [[NSMutableArray alloc] initWithContentsOfFile:kOrganizationFilePathKey];
//        [organizations addObject:organization];
//    }
//    else{
//        organizations = [[NSMutableArray alloc] initWithObjects:organization, nil];
//    }
//    
//    [organizations writeToFile:[self filePathWithKey:kOrganizationFilePathKey] atomically:YES];
//}


+ (id)sharedManager {
    static FileManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
@end

