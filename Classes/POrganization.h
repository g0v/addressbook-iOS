//
//  POrganization.h
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

@interface POrganization : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (strong, readonly) NSString *name;

@property (strong, readonly) NSArray *otherNames;
@property (strong, readonly) NSString *formerName;

@property (strong, readonly) NSString *classification;

@property (strong, readonly) NSArray *identifiers;
@property (strong, readonly) NSArray *contactDetails;

@property (strong, readonly) NSDate *createdDate;
@property (strong, readonly) NSDate *updatedDate;
@property (strong, readonly) NSDate *foundingDate;
@property (strong, readonly) NSDate *dissolutionDate;

@property (strong, readonly) NSString *image;

@property (strong, readonly) NSString *externalLinks;

@property (strong, readonly) NSString *parentID;
@property (strong, readonly) POrganization *parent;

@property (strong, readonly) NSArray *memberships;
@property (strong, readonly) NSArray *posts;

@end
