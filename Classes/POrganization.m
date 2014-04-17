//
//  POrganization.m
//
//  Created by Superbil on 2014/4/17.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "POrganization.h"

@interface POrganization ()
@property (strong) NSDictionary *rawData;
@end

@implementation POrganization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil || [dictionary isKindOfClass:[NSDictionary class]] == NO) {
        return nil;
    }

    self = [super init];
    if (self) {
        _rawData = dictionary;

        _name = [dictionary valueForKeyPath:@"name"];
        _parentID = [dictionary valueForKeyPath:@"parent_id"];
        _classification = [dictionary valueForKeyPath:@"classification"];
        _image = [dictionary valueForKeyPath:@"image"];
    }

    return self;
}

- (NSString *)description
{
    return [self.rawData description];
}

@end
