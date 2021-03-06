//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ContainerControllerProtocol.h"
#import "MenuViewController.h"

@protocol MainControllerContainerDelegate
- (void)presentBottomController;
@end

@interface MainControllerContainer : UIViewController <ContainerControllerProtocol, MainControllerContainerDelegate, MenuViewControllerDelegate>
{
    UIViewController *topController;
    UIViewController *bottomController;
    UIScrollView *topScrollView;
}
- (id)initWithFrontViewController:(UIViewController *)frontController backViewController:(UIViewController *)backController;
@end