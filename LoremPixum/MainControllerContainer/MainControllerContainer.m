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
    CGRect screenFrame = [self viewsFrame];
    topScrollView = [[UIScrollView alloc] initWithFrame:screenFrame];
    topScrollView.frame = CGRectMake(topScrollView.frame.origin.x, topScrollView.frame.origin.y, topScrollView.frame.size.width, topScrollView.frame.size.height);
    [self.view addSubview:topScrollView];
    if(topController != nil && bottomController != nil)
        [self initChildViewControllers];
}

- (CGRect)viewsFrame
{
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        screenFrame = CGRectMake(screenFrame.origin.x, screenFrame.origin.y, screenFrame.size.width, screenFrame.size.height - 20);
    }

    return screenFrame;
}

- (void)loadView
{
    self.view = [[MainContainerView alloc] initWithFrame:[self viewsFrame]];
}

- (void)initChildViewControllers
{
    [self addChildViewController:topController];
    [self addChildViewController:bottomController];

    [topScrollView addSubview:topController.view];
    [topScrollView setBackgroundColor:[UIColor clearColor]];
    topController.view.frame = CGRectMake(200, 0, topController.view.frame.size.width, topScrollView.frame.size.height);
    [topScrollView setContentSize:CGSizeMake(200 + topController.view.frame.size.width, topScrollView.frame.size.height)];
    [topScrollView setContentOffset:CGPointMake(200, 0)];
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

@end