//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MenuViewController.h"


@implementation MenuViewController {

}
- (void)didSelectItem:(int)item
{
    [self.delegate didSelectItem:item];
}

- (void)viewDidLoad
{
    MenuView *view = (MenuView *)self.view;
    view.delegate = self;
}

@end