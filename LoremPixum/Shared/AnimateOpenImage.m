//
// Created by Marek Mościchowski on 07.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AnimateOpenImage.h"
#import "SecondScreenController.h"
#import "SecondScreenImagePack.h"
#import "FirstView.h"
#import "FirstScreenController.h"
#import "SecondScreenView.h"


@implementation AnimateOpenImage {

}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. obtain state from the context
    SecondScreenController *secondScreenController = (SecondScreenController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [secondScreenController setBackgroundImage:[UIImage imageNamed:@"gowno.jpg"]];
    FirstScreenController *firstScreenController= (FirstScreenController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 2. obtain the container view
    UIView *containerView = [transitionContext containerView];

    UIImage *screenShot = [self screenShotFromView:firstScreenController.view];

    CGRect upperRect = CGRectMake(0, 0, _rowFrame.size.width, _rowFrame.origin.y);
    CGFloat rowBottom = _rowFrame.origin.y + _rowFrame.size.height;
    CGRect lowerRect = CGRectMake(0, rowBottom, _rowFrame.size.width, screenShot.size.height - rowBottom);

    UIImage *upperImage = [self cropImage:screenShot withRect:upperRect];
    UIImage *lowerImage = [self cropImage:screenShot withRect:lowerRect];

    UIImageView *upperImageView = [[UIImageView alloc] initWithImage:upperImage];
    upperImageView.frame = upperRect;

    UIImageView *lowerImageView = [[UIImageView alloc] initWithImage:lowerImage];
    lowerImageView.frame = lowerRect;

    [containerView addSubview:secondScreenController.view];
    [containerView addSubview:upperImageView];
    [containerView addSubview:lowerImageView];


    // 5. animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    [UIView animateWithDuration:duration animations:^{

        lowerImageView.frame = CGRectMake(0, 600, 320, 500);
        upperImageView.frame = CGRectMake(0, -500, 320, 500);

    } completion:^(BOOL finished) {

        // 6. inform the context of completion
        [transitionContext completeTransition:YES];

    }];

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

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

}


@end