//
//  PopoloOtherName.h
//
//  Created by Superbil on 2014/4/22.
//
//

#import "JSONModel.h"

@protocol PopoloOtherName
@end

/**
 Other name

 An alternate or former name

 JSON Schema: http://popoloproject.com/schemas/other_name.json#
 */

@interface PopoloOtherName : JSONModel

/**
 name

 An alternate or former name
 */
@property (nonatomic, copy) NSString *name;

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
 start_date

 The date on which the name was adopted
 */
@property (nonatomic, strong) NSString<Optional> *start_date;

/**
 end_date

 The date on which the name was abandoned
 */
@property (nonatomic, strong) NSString<Optional> *end_date;

/**
 note

 A note, e.g. 'Birth name'
 */
@property (nonatomic, strong) NSString<Optional> *note;

@end
