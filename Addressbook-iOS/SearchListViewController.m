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

@property (nonatomic, strong) PgRestOrganizationResult *organizationResult;
@property (nonatomic, strong) PgRestPersonResult *personResult;
@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (nonatomic, weak) IBOutlet UIButton *organizationButton;
@property (nonatomic, weak) IBOutlet UIButton *personButton;
@property (nonatomic, assign) BOOL enableSearchOrganization;
@property (nonatomic, assign) BOOL enableSearchPerson;

@end

@implementation SearchListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

#ifdef DEBUG
    self.searchTextField.text = @"張";
#endif

    [self.organizationButton addTarget:self
                                action:@selector(organizationButtonActionWithSender:)
                      forControlEvents:UIControlEventTouchUpInside];

    [self.personButton addTarget:self
                          action:@selector(personButtonActionWithSender:)
                forControlEvents:UIControlEventTouchUpInside];

    self.enableSearchOrganization = YES;
    self.enableSearchPerson = YES;
    [self updateButtonImage];
}

#pragma mark - UI action

- (void)organizationButtonActionWithSender:(id)sender
{
    self.enableSearchOrganization = !self.enableSearchOrganization;

    [self updateButtonImage];
}

- (void)personButtonActionWithSender:(id)sender
{
    self.enableSearchPerson = !self.enableSearchPerson;

    [self updateButtonImage];
}

- (void)updateButtonImage
{
    if (self.enableSearchOrganization) {
        [self.organizationButton setImage:[UIImage imageNamed:@"organization_selected.png"] forState:UIControlStateNormal];
    } else {
        [self.organizationButton setImage:[UIImage imageNamed:@"organization_normal.png"] forState:UIControlStateNormal];
    }

    if (self.enableSearchPerson) {
        [self.personButton setImage:[UIImage imageNamed:@"person_selected.png"] forState:UIControlStateNormal];
    } else {
        [self.personButton setImage:[UIImage imageNamed:@"person_normal.png"] forState:UIControlStateNormal];
    }
}

#pragma - ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /* Send search result */
    if ([segue.identifier isEqualToString:PushToSearchResultIdentifier]) {
        SearchResultViewController *searchResultVC = segue.destinationViewController;
        searchResultVC.title = self.searchTextField.text;

        if (self.enableSearchOrganization) {
            searchResultVC.organizations = self.organizationResult;
        }
        if (self.enableSearchPerson) {
            searchResultVC.persons = self.personResult;
        }

        [TSMessage setDefaultViewController:searchResultVC];
    }
}

#pragma mark - Search

- (IBAction)TextFieldDidEndOnExit:(id)sender
{
    /* Check error */
    NSString *searchText = self.searchTextField.text;

    if (!searchText || searchText.length == 0) {
        if ([sender canResignFirstResponder]) {
            [sender resignFirstResponder];
        }
        return;
    }

    if (self.enableSearchOrganization == NO && self.enableSearchPerson == NO) {
        [TSMessage showNotificationInViewController:self
                                              title:@"沒有選擇搜尋的項目"
                                           subtitle:@"必需選擇一項搜尋條件"
                                               type:TSMessageNotificationTypeWarning];
        return;
    }

    self.organizationResult = nil;
    self.personResult = nil;

    // Prepare to search
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

    NSMutableArray *tasks = [NSMutableArray array];
    if (self.enableSearchOrganization) {
        [tasks addObject:orgTask];
    }
    if (self.enableSearchPerson) {
        [tasks addObject:personTask];
    }

    /* Start Serach */
    BFTask *fetchRequest = [BFTask taskForCompletionOfAllTasks:tasks];
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

@end
