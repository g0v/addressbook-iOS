//
//  SearchListViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "SearchListViewController.h"

static NSString *govCellReuseIdentifier = @"govCellReuseIdentifier";

@interface SearchListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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
    
    BFTask *task = [[G0VAddressbookClient sharedClient] fetchOrganizations];
    self.organizations = task.result;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.organizations.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:govCellReuseIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:govCellReuseIdentifier];
    }
    
    NSDictionary *orgDic = self.organizations[indexPath.row];
    NSString *name = [orgDic valueForKeyPath:@"name"];
    NSString *identifier = [orgDic valueForKeyPath:@"identifiers.identifier"];
    NSString *detail = [orgDic valueForKeyPath:@"contact_details.value"];
    
    
    NSLog(@"identifier :%@",identifier);
    cell.textLabel.text = name;
    cell.detailTextLabel.text = detail;
    
    return cell;
}

#pragma mark - Table View DataDelegate

@end
