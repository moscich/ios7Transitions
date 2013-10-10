//
// Created by Marek Mościchowski on 09.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WelcomeScreenController.h"
#import "ContainerControllerProtocol.h"
#import "LoremPixumImporterProtocol.h"
#import "LoremPixumImporter.h"
#import "WelcomeScreenView.h"
#import "FirstScreenController.h"
#import "WelcomeOpenAnimation.h"


@implementation WelcomeScreenController {

}

- (void)viewDidLoad
{
    NSObject <LoremPixumImporterProtocol> *loremPixumImporter = [[LoremPixumImporter alloc] init];
    WelcomeScreenView *welcomeScreenView = (WelcomeScreenView *) self.view;
    welcomeScreenView.delegate = self;

    [loremPixumImporter getImageWithWidth:640 withHeight:1156 onCompletion:^(UIImage *image){
        [welcomeScreenView populateViewWithLowerImage:image];

    }];
    [loremPixumImporter getImageWithWidth:640 withHeight:1156 onCompletion:^(UIImage *image){
        [welcomeScreenView populateViewWithUpperImage:image];
    }];

    self.navigationController.navigationBarHidden = YES;
}

- (void)didSelect:(enum LowerUpperView)lowerUpperView
{
    FirstScreenController *firstScreenController = [[FirstScreenController alloc] initWithNibName:@"FirstScreenView" bundle:nil];
    self.navigationController.delegate = self;
    [self.navigationController setViewControllers:[NSArray arrayWithObject:firstScreenController ] animated:YES];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [[WelcomeOpenAnimation alloc] init];
}

@end