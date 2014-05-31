//
//  PopoloLink.h
//
//  Created by Superbil on 2014/4/22.
//
//

#import "JSONModel.h"

@protocol PopoloLink
@end

/**
 Link

 A URL

 JSON Schema: http://popoloproject.com/schemas/link.json#
 */

@interface PopoloLink : JSONModel

/**
 url

 A URL
 */
@property (nonatomic, copy) NSString *url;

/**
 note

 A note, e.g. 'Wikipedia page'
 */
@property (nonatomic, strong) NSString<Optional> *note;

@end
