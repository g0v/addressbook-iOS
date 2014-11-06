//
//  DetailViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "DetailViewController.h"

#import "UIImageView+AFNetworking.h"

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
    
    //Name
    self.nameLabel.text = [self.onePopolo valueForKeyPath:@"name"];

    //Phone
    self.phone = [[[self.onePopolo valueForKeyPath:@"contact_details"] firstObject] valueForKey:@"value"];
    NSString *phoneString = (self.phone)? self.phone : @"無";
    self.telephoneCell.detailTextLabel.text = phoneString;

    //Photo
    NSString *imageURLString = [self.onePopolo valueForKeyPath:@"image"];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    if (imageURLString) {
        [self.profileImageCell.imageView setImageWithURL:imageURL];
        self.profileImageCell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    
    NSString *email = [self.onePopolo valueForKeyPath:@"email"];
    NSString *emailString = (email)? email:@"無";
    self.emailCell.textLabel.text = emailString;
    //Party
//        [self.profileImageCell.imageView setImageWithURL:imageURL];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
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
