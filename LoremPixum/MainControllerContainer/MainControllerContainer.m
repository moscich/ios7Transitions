//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MainControllerContainer.h"
#import "MenuView.h"
#import "MainContainerView.h"
#import "WelcomeScreenController.h"
#import "FirstScreenController.h"
#import "GridScreenController.h"
#import "LoremPixumImporter.h"
#import "GridScreenModel.h"


@implementation MainControllerContainer {
    WelcomeScreenController* welcomeScreenController;
    FirstScreenController* firstScreenController;
    GridScreenController* gridScreenController;
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

    [self didSelectItem:2];
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

- (void)didSelectItem:(int)item
{
    UINavigationController *navigationController = (UINavigationController *)topController;
    switch(item)
    {
        case 0:
            if(welcomeScreenController == nil)
                welcomeScreenController = [[WelcomeScreenController alloc] initWithNibName:@"WelcomeScreenView" bundle:nil];
            [navigationController setViewControllers:[NSArray arrayWithObject:welcomeScreenController] animated:NO];
            break;
        case 1:
            if(firstScreenController == nil)
                firstScreenController = [[FirstScreenController alloc] initWithNibName:@"FirstScreenView" bundle:nil];
            [navigationController setViewControllers:[NSArray arrayWithObject:firstScreenController] animated:NO];
            break;
        case 2:
            if(gridScreenController == nil)
            {
                gridScreenController = [[GridScreenController alloc] initWithNibName:@"DynamicsScreenView" bundle:nil];
                gridScreenController.gridScreenModel = [[GridScreenModel alloc] initWithLorem:[[LoremPixumImporter alloc] init]];
            }
            [navigationController setViewControllers:[NSArray arrayWithObject:gridScreenController] animated:NO];
            break;
        default:break;
    }
}

@end