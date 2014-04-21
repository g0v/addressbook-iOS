//
//  PopoloLink.h
//
//  Created by Superbil on 2014/4/22.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "JSONModel.h"

@protocol PopoloLink
@end

/**
 Link

 A URL

 JSON Schema: http://json-schema.org/draft-03/schema
 */

@interface PopoloLink : JSONModel

/**
 A URL
 */
@property (nonatomic, strong) NSString *url;
/**
 A note, e.g. 'Wikipedia page'
 */
@property (nonatomic, strong) NSString<Optional> *note;

@end
