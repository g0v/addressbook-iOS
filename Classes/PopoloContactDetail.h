//
//  PopoloContactDetail.h
//
//  Created by Superbil on 2014/4/22.
//
//

#import "JSONModel.h"
#import "PopoloLink.h"

@protocol PopoloContactDetail
@end

/**
 Contact detail

 A means of contacting an entity

 JSON Schema: http://popoloproject.com/schemas/contact_detail.json#
 */

@interface PopoloContactDetail : JSONModel

/**
 label

 A human-readable label for the contact detail
 */
@property (nonatomic, strong) NSString<Optional> *label;

/**
 type

 A type of medium, e.g. 'fax' or 'email'
 */
@property (nonatomic, copy) NSString *type;

/**
 value

 A value, e.g. a phone number or email address
 */
@property (nonatomic, copy) NSString *value;

/**
 note

 A note, e.g. for grouping contact details by physical location
 */
@property (nonatomic, strong) NSString<Optional> *note;

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

 URLs to documents from which the contact detail is derived
 */
@property (nonatomic, strong) NSArray<Optional, PopoloLink> *sources;

@end
