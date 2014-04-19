//
//  SearchResultViewController.m
//  Addressbook-iOS
//
//  Created by Allen Lin on 4/19/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "SearchResultViewController.h"
#import "DetailViewController.h"

static NSString *govCellReuseIdentifier = @"govCellReuseIdentifier";

static NSString *PushToDetailResultIdentifier = @"PushToDetailResultIdentifier";


@interface SearchResultViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *organization;
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
    
//    NSLog(@"self.organizations :%@",self.organizations);
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:govCellReuseIdentifier];
    }
    
    NSDictionary *orgDic = self.organizations[indexPath.row];
    NSString *name = [orgDic valueForKeyPath:@"name"];
    
    cell.textLabel.text = name;
    return cell;
}

#pragma mark - Table View DataDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.organization = self.organizations[indexPath.row];
    
    [self performSegueWithIdentifier:PushToDetailResultIdentifier sender:nil];
}

#pragma - 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:PushToDetailResultIdentifier]) {
        
        DetailViewController *dtVC = segue.destinationViewController;
        
        dtVC.organization = self.organization;
        
    }
}

@end
