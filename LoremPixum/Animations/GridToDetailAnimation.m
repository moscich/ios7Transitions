//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GridToDetailAnimation.h"
#import "PopUpDetailController.h"


@implementation GridToDetailAnimation {

}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *viewController =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];

    BOOL popAnimation = NO;
    if(![viewController isKindOfClass:[PopUpDetailController class]])
    {
        popAnimation = YES;
    }
    if(!popAnimation)
    {
        [container addSubview:viewController.view];
        viewController.view.center = CGPointMake(container.center.x, container.center.y + 1000);
    }
    [UIView animateWithDuration:1.0 animations:^{
        if(!popAnimation)
        {
            viewController.view.center = container.center;
            fromViewController.view.alpha = 0.5;
        }
        else
        {
            viewController.view.alpha = 1.0;
            fromViewController.view.center = CGPointMake(container.center.x, container.center.y + 1000);
        }
    } completion:^(BOOL completed){
        if(popAnimation && !transitionContext.transitionWasCancelled)
            [fromViewController.view removeFromSuperview];

        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end