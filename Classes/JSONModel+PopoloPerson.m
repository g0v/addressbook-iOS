//
//  JSONModel+PopoloPerson.m
//  Addressbook-iOS
//
//  Created by 舒特比 on 2014/11/8.
//  Copyright (c) 2014年 g0v. All rights reserved.
//

#import "JSONModel+PopoloPerson.h"

@implementation JSONModel (PopoloPerson)

- (BOOL)isPerson {
    return [self isKindOfClass:[PopoloPerson class]];
}

@end
