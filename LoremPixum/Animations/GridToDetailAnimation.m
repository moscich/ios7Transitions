//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GridToDetailAnimation.h"
#import "PopUpDetailController.h"
#import "GridScreenController.h"
#import "FXBlurView.h"


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

    UIImageView *blurImageView = (UIImageView *)[container viewWithTag:101];
    UIScrollView *containerScrollView = (UIScrollView *)[container viewWithTag:102];

    BOOL popAnimation = NO;
    if(![viewController isKindOfClass:[PopUpDetailController class]])
    {
        popAnimation = YES;
        blurImageView;
        containerScrollView;
    }
    if(!popAnimation)
    {
        [container addSubview:viewController.view];
        viewController.view.center = CGPointMake(container.center.x, container.center.y + viewController.view.frame.size.height);
        UIImage *screenShot = [self screenShotFromView:fromViewController.view];

        blurImageView.image = [screenShot blurredImageWithRadius:10.0 iterations:3 tintColor:[UIColor clearColor]];
    }
    [UIView animateWithDuration:1.0 animations:^{
        if(!popAnimation)
        {
            viewController.view.center = container.center;
            containerScrollView.alpha = 0.0;
            blurImageView.alpha = 1.0;
        }
        else
        {
            viewController.view.alpha = 1.0;
            containerScrollView.alpha = 1.0;
            blurImageView.alpha = 0.0;
//            fromViewController.view.center = CGPointMake(container.center.x, container.center.y + fromViewController.view.frame.size.height);
        }
    } completion:^(BOOL completed){
        if(popAnimation && !transitionContext.transitionWasCancelled)
            [fromViewController.view removeFromSuperview];

        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (UIImage *)screenShotFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}

- (UIImage*) blur:(UIImage*)theImage
{
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];

    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:5.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];

    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];

    return [UIImage imageWithCGImage:cgImage];

    // if you need scaling
    // return [[self class] scaleIfNeeded:cgImage];
}

@end