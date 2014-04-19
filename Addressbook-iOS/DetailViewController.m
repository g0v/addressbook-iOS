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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *partyImageView;

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
    
    /* 找尋電話 */
    NSArray *contactDetails = [self.organization valueForKeyPath:@"contact_details"];
    
    NSString *phone;
    
    for(NSDictionary *contact in contactDetails){
        
        if ([[contact valueForKey:@"type"] isEqualToString:@"voice"]) {
        
            phone = [contact valueForKey:@"value"];
        
            break;
            
        }
        
    }
    
    if (!phone || phone.length==0) {
        
    }
    
    self.telephoneCell.detailTextLabel.text = phone;
    
    
    
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



@end
