//
//  PopoloOrganization.h
//
//  Created by Superbil on 2014/4/22.
//
//

#import "JSONModel.h"

#import "PopoloContactDetail.h"
#import "PopoloIdentifier.h"
#import "PopoloLink.h"
#import "PopoloOtherName.h"

@protocol PopoloOrganization
@end

/**
 Organization

 A group with a common purpose or reason for existence that goes beyond the set of people belonging to it

 JSON Schema: http://popoloproject.com/schemas/organization.json#
 */

@interface PopoloOrganization : JSONModel

/**
 id

 The organization's unique identifier
 */
@property (nonatomic, strong) NSString<Optional> *id;

/**
 name

 A primary name, e.g. a legally recognized name
 */
@property (nonatomic, strong) NSString<Optional> *name;

/**
 other_names

 Alternate or former names
 */
@property (nonatomic, strong) NSArray<Optional, PopoloOtherName> *other_names;

/**
 identifiers

 Issued identifiers
 */
@property (nonatomic, strong) NSArray<Optional, PopoloIdentifier> *identifiers;

/**
 classification

 An organization category, e.g. committee
 */
@property (nonatomic, strong) NSString<Optional> *classification;

/**
 parent_id

 The ID of the organization that contains this organization
 */
@property (nonatomic, strong) NSString<Optional> *parent_id;

/**
 parent

 The organization that contains this organization
 */
@property (nonatomic, strong) NSString<Optional> *parent;

/**
 founding_date

 A date of founding
 */
@property (nonatomic, strong) NSString<Optional> *founding_date;

/**
 dissolution_date

 A date of dissolution
 */
@property (nonatomic, strong) NSString<Optional> *dissolution_date;

/**
 image

 A URL of an image
 */
@property (nonatomic, strong) NSString<Optional> *image;

/**
 contact_details

 Means of contacting the organization
 */
@property (nonatomic, strong) NSArray<Optional, PopoloContactDetail> *contact_details;

/**
 links

 URLs to documents about the organization
 */
@property (nonatomic, strong) NSArray<Optional, PopoloLink> *links;

/**
 created_at

 The time at which the resource was created
 */
@property (nonatomic, strong) NSString<Optional> *created_at;

/**
 updated_at

 The time at which the resource was last modified
 */
@property (nonatomic, strong) NSString<Optional> *updated_at;

/**
 sources

 URLs to documents from which the organization is derived
 */
@property (nonatomic, strong) NSArray<Optional, PopoloLink> *sources;

@end
