//
//  BookmarkViewController.m
//  Addressbook-iOS
//
//  Created by allenlinli on 9/21/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import "BookmarkViewController.h"


static NSString * const BookmarkCellID = @"BookmarkReuseIdentifier";

@interface BookmarkViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation BookmarkViewController

#pragma mark - UITableViewDatasource

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self dataFromSection:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BookmarkCellID
                                                            forIndexPath:indexPath];
    
    NSArray *dataList = [self dataFromSection:indexPath.section];
    id data = dataList[indexPath.row];
    
    cell.textLabel.text = [data valueForKeyPath:@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate



@end
