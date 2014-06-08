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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.nameLabel.text = [self.onePopolo valueForKeyPath:@"name"];

    /* find phone number */
    self.phone = [[[self.onePopolo valueForKeyPath:@"contact_details"] firstObject] valueForKey:@"value"];

    self.telephoneCell.detailTextLabel.text = self.phone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.phone.length) {
        return;
    }

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"確定撥出嗎？"
                                                        message:self.phone
                                                       delegate:self
                                              cancelButtonTitle:@"饒他一馬"
                                              otherButtonTitles:@"怕落去啦", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
            
        case 1:
        {
            NSString *dailText = [NSString stringWithFormat:@"tel:%@", self.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dailText]];
            NSLog(@"dailText: %@",dailText);
            break;
        }
            
        default:
            break;
    }
}


@end
