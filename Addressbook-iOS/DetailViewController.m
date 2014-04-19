//
//  DetailViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "DetailViewController.h"



@interface DetailViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *profileImageCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *telephoneCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *partyImageView;
@property (strong, nonatomic) NSString *phone;
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
    
    self.nameLabel.text = [self.organization valueForKeyPath:@"name"];
    
    /* 找尋電話 */
    NSArray *contactDetails = [self.organization valueForKeyPath:@"contact_details"];
    
    for(NSDictionary *contact in contactDetails){
        
        if ([[contact valueForKey:@"type"] isEqualToString:@"voice"]) {
        
            self.phone = [contact valueForKey:@"value"];
        
            break;
            
        }
        
    }
    
    if (!self.phone || self.phone.length==0) {
        
    }
    
    self.telephoneCell.detailTextLabel.text = self.phone;
    
    
    
    
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"確定撥出嗎？" message:self.phone delegate:self cancelButtonTitle:@"饒他一馬" otherButtonTitles:@"怕落去啦", nil];
    
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
            
        case 1:
        {
            NSString *dailText = [NSString stringWithFormat:@"tel:%@",self.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dailText]];
            NSLog(@"dailText: %@",dailText);
        }
            break;
            
        default:
            break;
    }
}


@end
