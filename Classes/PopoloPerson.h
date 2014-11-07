//
//  PopoloPerson.h
//
//  Created by Superbil on 2014/4/22.
//
//

#import "JSONModel.h"

#import "PopoloContactDetail.h"
#import "PopoloIdentifier.h"
#import "PopoloLink.h"
#import "PopoloOtherName.h"

static NSString * const kKeyForEncodePopoloPerson;
static NSString * const kKeyForEncodePopoloOrganization;

@protocol PopoloPerson
@end

/**
 Person

 A real person, alive or dead

 JSON Schema: http://popoloproject.com/schemas/person.json#
 */

@interface PopoloPerson : JSONModel <NSCoding>

/**
 id

 The person's unique identifier
 */
@property (nonatomic, strong) NSString<Optional> *id;

/**
 name

 A person's preferred full name
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
 family_name

 One or more family names
 */
@property (nonatomic, strong) NSString<Optional> *family_name;

/**
 given_name

 One or more primary given names
 */
@property (nonatomic, strong) NSString<Optional> *given_name;

/**
 additional_name

 One or more secondary given names
 */
@property (nonatomic, strong) NSString<Optional> *additional_name;

/**
 honorific_prefix

 One or more honorifics preceding a person's name
 */
@property (nonatomic, strong) NSString<Optional> *honorific_prefix;

/**
 honorific_suffix

 One or more honorifics following a person's name
 */
@property (nonatomic, strong) NSString<Optional> *honorific_suffix;

/**
 patronymic_name

 One or more patronymic names
 */
@property (nonatomic, strong) NSString<Optional> *patronymic_name;

/**
 sort_name

 A name to use in a lexicographically ordered list
 */
@property (nonatomic, strong) NSString<Optional> *sort_name;

/**
 email

 A preferred email address
 */
@property (nonatomic, strong) NSString<Optional> *email;

/**
 gender

 A gender
 */
@property (nonatomic, strong) NSString<Optional> *gender;

/**
 birth_date

 A date of birth
 */
@property (nonatomic, strong) NSString<Optional> *birth_date;

/**
 death_date

 A date of death
 */
@property (nonatomic, strong) NSString<Optional> *death_date;

/**
 image

 A URL of a head shot
 */
@property (nonatomic, strong) NSString<Optional> *image;

/**
 summary

 A one-line account of a person's life
 */
@property (nonatomic, strong) NSString<Optional> *summary;

/**
 biography

 An extended account of a person's life
 */
@property (nonatomic, strong) NSString<Optional> *biography;

/**
 national_identity

 A national identity
 */
@property (nonatomic, strong) NSString<Optional> *national_identity;

/**
 contact_details

 Means of contacting the person
 */
@property (nonatomic, strong) NSArray<Optional, PopoloContactDetail> *contact_details;

/**
 links

 URLs to documents about the person
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

 URLs to documents from which the person is derived
 */
@property (nonatomic, strong) NSArray<Optional, PopoloLink> *sources;

@end
