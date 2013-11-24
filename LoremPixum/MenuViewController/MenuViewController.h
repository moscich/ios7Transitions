//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "MenuView.h"

@protocol MenuViewControllerDelegate
- (void)didSelectItem:(int)item;
@end

@interface MenuViewController : UIViewController <MenuViewDelegate>

@property (nonatomic, assign) id <MenuViewControllerDelegate> delegate;

@end