//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol MenuViewDelegate
- (void)didSelectItem:(int)item;
@end

@interface MenuView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataSource;
    IBOutlet UITableView *tableView;
}

@property (nonatomic, assign) id <MenuViewDelegate> delegate;

@end