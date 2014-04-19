//
//  DetailViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *profileImageCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *telephoneCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;

@end

@implementation DetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = [self.organization valueForKeyPath:@"name"];
//    NSString *identifierOfOnePopolo = [onePopolo valueForKeyPath:@"id"];
//    XCTAssertNotNil(identifierOfOnePopolo, @"This must had value.");
//    
//    NSString *name = [onePopolo valueForKeyPath:@"name"];
//    XCTAssertNotNil(name, @"This should had name.");
//    
//    // got identifiers
//    NSLog(@"identifiers: %@", [onePopolo valueForKeyPath:@"identifiers.identifier"]);
//    
//    // got contact_details
//    NSLog(@"contact details: %@", [onePopolo valueForKeyPath:@"contact_details.value"]);

    
}



@end
