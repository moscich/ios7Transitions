//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MainControllerContainer.h"
#import "MenuView.h"
#import "MainContainerView.h"


@implementation MainControllerContainer {

}

- (id)initWithFrontViewController:(UIViewController *)frontController backViewController:(UIViewController *)backController
{
    self = [super init];

    if(self)
    {
        topController = frontController;
        bottomController = backController;
    }
    return self;
}

- (void)viewDidLoad
{
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    topScrollView = [[UIScrollView alloc] initWithFrame:screenFrame];
    [self.view addSubview:topScrollView];
    if(topController != nil && bottomController != nil)
        [self initChildViewControllers];
}

- (void)loadView
{
    self.view = [[MainContainerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)initChildViewControllers
{
    [self addChildViewController:topController];
    [self addChildViewController:bottomController];

    [topScrollView addSubview:topController.view];
    [topScrollView setBackgroundColor:[UIColor clearColor]];
    topController.view.frame = CGRectMake(200, 0, topController.view.frame.size.width, topController.view.frame.size.height);
    [topScrollView setContentSize:CGSizeMake(200 + topController.view.frame.size.width, topController.view.frame.size.height)];
    [topScrollView setContentOffset:CGPointMake(200, 0)];
    topScrollView.bounces = NO;
    [self.view insertSubview:bottomController.view belowSubview:topScrollView];
    ((MainContainerView *)self.view).menuView = bottomController.view;
    ((MainContainerView *)self.view).scrollView = topScrollView;
}

- (void)setFrontViewController:(UIViewController *)frontController backViewController:(UIViewController *)backController
{
    topController = frontController;
    bottomController = backController;
    [self initChildViewControllers];
}

- (void)presentBottomController
{
    if([topScrollView contentOffset].x == 200)
        [topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    else
        [topScrollView setContentOffset:CGPointMake(200, 0) animated:YES];
}


@end