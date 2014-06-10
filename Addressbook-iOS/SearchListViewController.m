//
//  SearchListViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchResultViewController.h"
#import "TSMessage.h"

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

        [TSMessage setDefaultViewController:searchResultVC];
    }
}

/* Search */
- (IBAction)searchTextFieldEditingDidEnd:(id)sender
{
    /* Check error */
    NSString *searchText = self.searchTextField.text;

    if (!searchText || searchText.length == 0) {
        if ([sender canResignFirstResponder]) {
            [sender resignFirstResponder];
        }
        return;
    }

    BFTask *orgTask = [[[G0VAddressbookClient sharedClient] fetchOrganizationsWithMatchesString:searchText] continueWithSuccessBlock:^id(BFTask *task) {
        if (task.result) {
            PgRestOrganizationResult *orgResult = task.result;
            self.organizationResult = orgResult;
        }
        return nil;
    }];

    BFTask *personTask = [[[G0VAddressbookClient sharedClient] fetchPersonsWithMatchesString:searchText] continueWithSuccessBlock:^id(BFTask *task) {
        if (task.result) {
            PgRestPersonResult *personResult = task.result;
            self.personResult = personResult;
        }
        return nil;
    }];

    /* Start Serach */
    BFTask *fetchRequest = [BFTask taskForCompletionOfAllTasks:@[orgTask,personTask]];
    [fetchRequest continueWithBlock:^id(BFTask *task) {

        /* Change to next page */
        [self performSegueWithIdentifier:PushToSearchResultIdentifier sender:nil];

        if (task.error) {
            NSString *errorTitle = @"其他錯誤";
            if ([task.error.domain isEqualToString:NSURLErrorDomain] || [task.error.domain isEqualToString:AFNetworkingErrorDomain]) {
                errorTitle = @"網路錯誤";
            }
            [TSMessage showNotificationWithTitle:errorTitle
                                        subtitle:[task.error localizedDescription]
                                            type:TSMessageNotificationTypeError];
            return nil;
        }

        // only show message when |task.result| had nothing
        if (self.organizationResult.entries.count + self.personResult.entries.count == 0) {

            [TSMessage showNotificationWithTitle:@"沒有符合的資料"
                                        subtitle:@"請重新輸入查詢條件"
                                            type:TSMessageNotificationTypeMessage];
        }

        return nil;
    }];
}

- (IBAction)TextFieldDidEndOnExit:(id)sender {
}

@end
