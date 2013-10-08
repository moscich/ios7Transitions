//
// Created by Marek Mościchowski on 04.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SecondScreenController.h"
#import "SecondScreenImagePack.h"
#import "SecondScreenView.h"
#import "AnimateOpenImage.h"


@implementation SecondScreenController
{
    BOOL gestureAccepted;
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    BOOL interactiveTransition;
}

- (void)setImagePack:(SecondScreenImagePack *)_imagePack
{
    imagePack = _imagePack;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    ((SecondScreenView *) self.view).backgroundImageView.image = backgroundImage;
}

- (void)viewDidLoad
{
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didReceivePanGesture:)]];
    percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    interactiveTransition = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.delegate = self;
}

- (void)didReceivePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if([panGestureRecognizer locationInView:self.view].x > 50)
        {
            gestureAccepted = NO;
        }
        else
        {
            interactiveTransition = YES;
            [self.navigationController popViewControllerAnimated:YES];
            gestureAccepted = YES;
        }
    }
    if(gestureAccepted && panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        float percent = [panGestureRecognizer translationInView:self.view].x/170;
        [percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }
    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if([panGestureRecognizer velocityInView:self.view].x > 0)
            [percentDrivenInteractiveTransition finishInteractiveTransition];
        else
            [percentDrivenInteractiveTransition cancelInteractiveTransition];
        gestureAccepted = YES;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return self.animateOpenImage;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    if(interactiveTransition)
        return percentDrivenInteractiveTransition;
    else
        return nil;
}

@end