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
    return filePath;
}

- (NSString *)peopleFilePath
{
    NSString *peoplePath = [self filePathWithKey:kKeyForEncodePopoloPerson];
    return peoplePath;
}

- (NSArray *)readPeople
{
    NSError *error;
    NSArray *peopleFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self peopleFilePath] error:&error];
    if (peopleFiles.count ==0) {
        NSLog(@"peopleFiles.count ==0");
        return nil;
    }
    
    return [peopleFiles bk_map:^id(NSString *personFilePath) {
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:personFilePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        PopoloPerson *person = [unarchiver decodeObjectForKey:kKeyForEncodePopoloPerson];
        [unarchiver finishDecoding];
        return person;
    }];
}

- (NSArray *)readOrganizations
{
    NSArray *organizations = nil;
    NSString *path = [self filePathWithKey:kOrganizationFilePathKey];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        organizations = [[NSArray alloc] initWithContentsOfFile:kOrganizationFilePathKey];
    }
    
    return organizations;
}

- (void)writePerson:(PopoloPerson *)person
{
    NSString *filePath = [[self peopleFilePath] stringByAppendingString:[person valueForKey:@"id"]];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:person forKey:kKeyForEncodePopoloPerson];
    [archiver finishEncoding];
    NSError *error;
    BOOL didWrite = [data writeToFile:filePath options:NSDataWritingAtomic error:&error];
    if (didWrite) {
        NSLog(@"did writePerson");
    }
    else{
        NSLog(@"error:%@",error);
        NSLog(@"did not writePerson");
    }
}

- (void)writeOrganization:(PopoloOrganization *)organization
{
    NSString *filePath = [[self filePathWithKey:kOrganizationFilePathKey] stringByAppendingPathComponent:organization.id];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
                                 initForWritingWithMutableData:data];
    [archiver encodeObject:organization forKey:kKeyForEncodePopoloOrganization];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:[self peopleFilePath]]) {
            NSError *error;
            BOOL didCreate = [[NSFileManager defaultManager] createDirectoryAtPath:[self peopleFilePath] withIntermediateDirectories:NO attributes:nil error:&error];
            if (didCreate) {
                NSLog(@"didCreate folder");
            }
            else{
                NSLog(@"didCreate folder, error:%@",error);
            }
        }
        NSString *organizationsPath = [self filePathWithKey:kKeyForEncodePopoloOrganization];
        if (![[NSFileManager defaultManager] fileExistsAtPath:organizationsPath]) {
            NSError *error;
            BOOL didCreate = [[NSFileManager defaultManager] createDirectoryAtPath:organizationsPath withIntermediateDirectories:NO attributes:nil error:&error];
            if (didCreate) {
                NSLog(@"didCreate folder");
            }
            else{
                NSLog(@"didCreate folder, error:%@",error);
            }
        }
    }
    return self;
}

+ (id)sharedInstance {
    static FileManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end