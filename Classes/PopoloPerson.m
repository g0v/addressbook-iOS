//
//  PopoloPerson.m
//
//  Created by Superbil on 2014/4/22.
//
//

#import "PopoloPerson.h"

static NSString * const kKeyForEncodePopoloPerson = @"kKeyForEncodePopoloPerson";
static NSString * const kKeyForEncodePopoloOrganization = @"kKeyForEncodePopoloOrganization";

static NSString * const kKeyForEncodeName = @"kKeyForEncodeName";
static NSString * const kKeyForEncodeId = @"kKeyForEncodeId";
static NSString * const kKeyForEncodeContactDetails = @"kKeyForEncodeContactDetails";
static NSString * const kKeyForEncodeImage = @"kKeyForEncodeImage";

//static NSString * const kKeyForEncodeName = @"kKeyForEncodeName";
//static NSString * const kKeyForEncodeName = @"kKeyForEncodeName";

@implementation PopoloPerson

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.name forKey:kKeyForEncodeName];

//    [aCoder encodeObject:self.id forKey:kKeyForEncodeId];
//    [aCoder encodeObject:self.contact_details forKey:kKeyForEncodeContactDetails];
//    NSString *phone = [[[self valueForKeyPath:@"contact_details"] firstObject] valueForKey:@"value"];
//    [aCoder encodeObject:self.image forKey:kKeyForEncodeImage];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.name = [aDecoder decodeObjectForKey:kKeyForEncodeName];
//        [self setValue:[aDecoder decodeObjectForKey:kKeyForEncodeId] forKey:@"id"];
//        self.contact_details = [aDecoder decodeObjectForKey:kKeyForEncodeContactDetails];
//        self.image = [aDecoder decodeObjectForKey:kKeyForEncodeImage];
    }
    return self;
}

@end
