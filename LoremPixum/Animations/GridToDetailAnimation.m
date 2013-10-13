//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GridToDetailAnimation.h"


@implementation GridToDetailAnimation {

}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *viewController =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];

    [container addSubview:viewController.view];

    viewController.view.center = CGPointMake(container.center.x, container.center.y + 1000);

    [UIView animateWithDuration:1.0 animations:^{
        viewController.view.center = container.center;
    } completion:^(BOOL completed){
        [transitionContext completeTransition:YES];
    }];
}

@end