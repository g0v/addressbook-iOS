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

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UIImageView *govImageView;

@property (weak, nonatomic) IBOutlet UIImageView *personImageView;

@property (nonatomic, strong) NSArray *organizations;

@end

@implementation SearchListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma -

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    /* 傳遞搜尋結果 */
    if ([segue.identifier isEqualToString:PushToSearchResultIdentifier]) {
        SearchResultViewController *srVC = segue.destinationViewController;
        srVC.title = self.searchTextField.text;
        srVC.organizations = self.organizations;
    }
}

- (IBAction)searchTextFieldEditingDidEnd:(id)sender {
    /* 搜尋 */
    
    /* 錯誤檢查 */
    NSString *searchText = self.searchTextField.text;
    
    if(!searchText || searchText.length==0){
        [sender resignFirstResponder];
        return;
    }
    
    
    /* 開始搜尋 */
    [[[G0VAddressbookClient sharedClient] fetchOrganizationsWithMatchesString:searchText] continueWithBlock:^id(BFTask *task) {
        
        /* 錯誤檢查 */
        
//        NSLog(@"task.result:%@",task.result);
        
        if(!task.result){
            
        }
        
        /* 記錄結果 */
        
        self.organizations = task.result;
        
        /* 換到下一頁 */
        
        [self performSegueWithIdentifier:PushToSearchResultIdentifier sender:nil];
        
        return nil;
    }];
}

- (IBAction)TextFieldDidEndOnExit:(id)sender {
}

@end
