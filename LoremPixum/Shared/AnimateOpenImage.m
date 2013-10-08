//
// Created by Marek Mościchowski on 07.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AnimateOpenImage.h"
#import "SecondScreenController.h"
#import "FirstView.h"
#import "FirstScreenController.h"
#import "SecondScreenView.h"


@implementation AnimateOpenImage {
    CGRect firstScreenFrame;
    CGRect beforeTransitionUpperFrame;
    CGRect beforeTransitionLowerFrame;
    UIImage *upperImage;
    UIImage *lowerImage;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    NSLog(@"canceled = %d", transitionContext.transitionWasCancelled);
    BOOL pushTransition;
    SecondScreenController *secondScreenController;
    FirstScreenController *firstScreenController;
    if([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[SecondScreenController class] ])
    {
        pushTransition = YES;
        secondScreenController = (SecondScreenController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        firstScreenController= (FirstScreenController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        firstScreenFrame = firstScreenController.view.frame;
    }
    else
    {
        pushTransition = NO;
        secondScreenController = (SecondScreenController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        firstScreenController= (FirstScreenController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }

    UIView *containerView = [transitionContext containerView];

    SecondScreenView *secondScreenView = (SecondScreenView *)secondScreenController.view;

    UIImage *screenShot = [self screenShotFromView:firstScreenController.view];

    UIImageView *upperImageView;
    UIImageView *lowerImageView;

    if(pushTransition) {
        beforeTransitionUpperFrame = CGRectMake(0, 0, _rowFrame.size.width, _rowFrame.origin.y);
        CGFloat rowBottom = _rowFrame.origin.y + _rowFrame.size.height;
        beforeTransitionLowerFrame = CGRectMake(0, rowBottom, _rowFrame.size.width, screenShot.size.height - rowBottom);

        upperImage = [self cropImage:screenShot withRect:beforeTransitionUpperFrame];
        lowerImage = [self cropImage:screenShot withRect:beforeTransitionLowerFrame];

        upperImageView = [[UIImageView alloc] initWithImage:upperImage];
        upperImageView.frame = beforeTransitionUpperFrame;

        lowerImageView = [[UIImageView alloc] initWithImage:lowerImage];
        lowerImageView.frame = beforeTransitionLowerFrame;

        secondScreenView.backgroundImageView.center = [self getFrameCenter:_rowFrame];

        [containerView addSubview:secondScreenController.view];
        [containerView addSubview:upperImageView];
        [containerView addSubview:lowerImageView];
    }
    else
    {
        upperImageView = [[UIImageView alloc] initWithImage:upperImage];
        upperImageView.frame = CGRectMake(0, -beforeTransitionUpperFrame.size.height, beforeTransitionUpperFrame.size.width, beforeTransitionUpperFrame.size.height);

        lowerImageView = [[UIImageView alloc] initWithImage:lowerImage];
        lowerImageView.frame = CGRectMake(0, secondScreenView.frame.size.height, beforeTransitionLowerFrame.size.width, beforeTransitionLowerFrame.size.height);

        [containerView addSubview:upperImageView];
        [containerView addSubview:lowerImageView];
        firstScreenController.view.frame = firstScreenFrame;
    }

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:duration animations:^{
        if(pushTransition) {
            lowerImageView.frame = CGRectMake(0, secondScreenView.frame.size.height, lowerImageView.frame.size.width, lowerImageView.frame.size.height);
            upperImageView.frame = CGRectMake(0, -upperImageView.frame.size.height, upperImageView.frame.size.width, upperImageView.frame.size.height);
            secondScreenView.backgroundImageView.center = secondScreenView.center;
        }
        else
        {
            lowerImageView.frame = beforeTransitionLowerFrame;
            upperImageView.frame = beforeTransitionUpperFrame;
            secondScreenView.backgroundImageView.center = [self getFrameCenter:_rowFrame];
        }

    } completion:^(BOOL finished) {

        [upperImageView removeFromSuperview];
        [lowerImageView removeFromSuperview];

        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];

        if(!pushTransition && !transitionContext.transitionWasCancelled)
            [containerView addSubview:firstScreenController.view];

    }];

}

- (CGPoint)getFrameCenter:(CGRect)rect
{
    return CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height/2);
}

- (UIImage *)cropImage:(UIImage *)image withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    [UIImage imageWithCGImage:imageRef];
    return [UIImage imageWithCGImage:imageRef];
}

- (UIImage *)screenShotFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}

//- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//    NSLog(@"Start interactive");
//    [self animateTransition:transitionContext];
//}


@end