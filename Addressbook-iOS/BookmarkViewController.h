//
//  BookmarkViewController.h
//  Addressbook-iOS
//
//  Created by allenlinli on 9/21/14.
//  Copyright (c) 2014 g0v. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarkViewController : UIViewController
@property (nonatomic, strong) PgRestOrganizationResult *organizations;
@property (nonatomic, strong) PgRestPersonResult *persons;
@end
