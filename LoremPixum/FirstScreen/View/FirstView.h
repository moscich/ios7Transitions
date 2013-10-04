//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface FirstView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataSource;
    IBOutlet UITableView *tableView;
}
- (void)populateView:(UIImage *)image;

@end