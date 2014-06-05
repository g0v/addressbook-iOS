//
//  SearchListViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchResultViewController.h"

static NSString *PushToSearchResultIdentifier = @"PushToSearchResultIdentifier";

@interface SearchListViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (nonatomic, weak) IBOutlet UIImageView *govImageView;
@property (nonatomic, weak) IBOutlet UIImageView *personImageView;
@property (nonatomic, strong) PgRestOrganizationResult *organizationResult;
@property (nonatomic, strong) PgRestPersonResult *personResult;

@end

@implementation SearchListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

#ifdef DEBUG
    self.searchTextField.text = @"張";
#endif
}

#pragma -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /* Send search result */
    if ([segue.identifier isEqualToString:PushToSearchResultIdentifier]) {
        SearchResultViewController *searchResultVC = segue.destinationViewController;
        searchResultVC.title = self.searchTextField.text;
        searchResultVC.organizations = self.organizationResult;
        searchResultVC.persons = self.personResult;
    }
}

/* Search */
- (IBAction)searchTextFieldEditingDidEnd:(id)sender
{
    /* Check error */
    NSString *searchText = self.searchTextField.text;

    if (!searchText || searchText.length==0) {
        [sender resignFirstResponder];
        return;
    }

    /* Start Serach */
    [[[[G0VAddressbookClient sharedClient] fetchOrganizationsWithMatchesString:searchText] continueWithBlock:^id(BFTask *task) {

        if(task.result){
            PgRestOrganizationResult *orgResult = task.result;
            self.organizationResult = orgResult;

            return [[G0VAddressbookClient sharedClient] fetchPersonsWithMatchesString:searchText];
        }

        return nil;
    }] continueWithBlock:^id(BFTask *task) {
        
        if (task.result) {
            PgRestPersonResult *personResult = task.result;
            self.personResult = personResult;
        }

        /* Change to next page */
        [self performSegueWithIdentifier:PushToSearchResultIdentifier sender:nil];

        return nil;
    }];
}

- (IBAction)TextFieldDidEndOnExit:(id)sender {
}

@end
