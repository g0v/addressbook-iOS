//
//  SearchResultViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "SearchResultViewController.h"

static NSString *govCellReuseIdentifier = @"govCellReuseIdentifier";

@interface SearchResultViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SearchResultViewController

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
    // Do any additional setup after loading the view.
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
