//
//  PopoloIdentifier.h
//
//  Created by Superbil on 2014/4/22.
//
//

#import "JSONModel.h"

@protocol PopoloIdentifier
@end

/**
 Identifier

 An issued identifier

 JSON Schema: http://popoloproject.com/schemas/identifier.json#
 */

@interface PopoloIdentifier : JSONModel

/**
 identifier

 An issued identifier, e.g. a DUNS number
 */
@property (nonatomic, copy) NSString *identifier;

/**
 scheme

 An identifier scheme, e.g. DUNS
 */
@property (nonatomic, strong) NSString<Optional> *scheme;

@end
