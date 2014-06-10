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

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *selectedIndex;

@end


@implementation SearchResultViewController

- (NSArray *)dataFromSection:(NSInteger)section
{
    if (section == 0) {
        return self.organizations.entries;
    }
    else if (section == 1) {
        return self.persons.entries;
    }
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // two data source |self.organizations| and |self.persions|
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self dataFromSection:section] ? [self dataFromSection:section].count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:govCellReuseIdentifier
                                                            forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:govCellReuseIdentifier];
    }

    NSArray *dataList = [self dataFromSection:indexPath.section];
    id data = dataList[indexPath.row];

    cell.textLabel.text = [data valueForKeyPath:@"name"];

    return cell;
}

#pragma mark - Table View DataDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // select on one row
    self.selectedIndex = indexPath;

    [self performSegueWithIdentifier:PushToDetailResultIdentifier sender:nil];
}

#pragma - 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:PushToDetailResultIdentifier]) {

        DetailViewController *detailVC = segue.destinationViewController;

        detailVC.onePopolo = [self dataFromSection:self.selectedIndex.section][self.selectedIndex.row];
    }
}

@end
