//
// Created by Marek Mościchowski on 10.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WelcomeOpenAnimation.h"
#import "WelcomeScreenController.h"


@implementation WelcomeOpenAnimation {

}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];

    WelcomeScreenController *welcomeScreenController = (WelcomeScreenController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    WelcomeScreenView *welcomeScreenView = welcomeScreenController.view;
    UIViewController *targetViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    [container insertSubview:targetViewController.view belowSubview:welcomeScreenController.view];

    NSTimeInterval animationTime = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:animationTime animations:^{

        welcomeScreenView.upperImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-.6), CGAffineTransformMakeTranslation(65, -330));
        welcomeScreenView.lowerImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(-.6), CGAffineTransformMakeTranslation(-65, 330));

    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end