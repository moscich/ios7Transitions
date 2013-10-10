//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FirstScreenController.h"
#import "LoremPixumImporter.h"
#import "SecondScreenController.h"
#import "AnimateOpenImage.h"
#import "ContainerControllerProtocol.h"


@implementation FirstScreenController
{
    AnimateOpenImage *transitionAnimation;
    BOOL interactiveTransition;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *openBottomControllerInContainer = [[UIBarButtonItem alloc] initWithTitle:@"Hey" style:UIBarButtonItemStylePlain target:self.delegate action:@selector(presentBottomController)];
    self.navigationItem.leftBarButtonItem = openBottomControllerInContainer;

    FirstView *_firstView = (FirstView *)self.view;
    _firstView.delegate = self;

    LoremPixumImporter *loremPixumImporter = [[LoremPixumImporter alloc] init];
    int width = 640;
    int height = 1136;

    for(int i = 0; i < 10; i++)
    {
        [loremPixumImporter getImageWithWidth:width withHeight:height onCompletion:^(UIImage *image)
        {
            FirstView *firstView = (FirstView *)self.view;
            if(image != nil)
                [firstView populateView:image];
        }];
    }
    interactiveTransition = NO;
    transitionAnimation = [[AnimateOpenImage alloc] init];
    percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    self.navigationController.delegate = self;

    [self.view addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didReceivePinchGesture:)]];
}

- (void)didReceivePinchGesture:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if(pinchGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        interactiveTransition = YES;
        CGPoint pinchLocation = [pinchGestureRecognizer locationInView:self.view];
        FirstView *_firstView = (FirstView *)self.view;
        [_firstView selectRowAtPoint:pinchLocation];
    }
    else if(pinchGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {

        [percentDrivenInteractiveTransition updateInteractiveTransition:pinchGestureRecognizer.scale - 1];
    }
    else if(pinchGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(pinchGestureRecognizer.velocity > 0)
            [percentDrivenInteractiveTransition finishInteractiveTransition];
        else
            [percentDrivenInteractiveTransition cancelInteractiveTransition];
        interactiveTransition = NO;
    }
}

- (void)loadView
{
    [super loadView];
}

- (void)didSelectRowWithFrame:(CGRect)frame withImage:(UIImage *)image
{
    transitionAnimation.rowFrame = frame;
    SecondScreenController *secondScreenController = [[SecondScreenController alloc] initWithNibName:@"SecondScreenView" bundle:nil];
    secondScreenController.animateOpenImage = transitionAnimation;
    [secondScreenController setBackgroundImage:image];
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:secondScreenController animated:YES];
}
- (void)navigateToSecondView:(SecondScreenImagePack *)imagePack
{
    SecondScreenController *secondScreenController = [[SecondScreenController alloc] initWithNibName:@"SecondScreenView" bundle:nil];

    [secondScreenController setImagePack:imagePack];
    [self.navigationController pushViewController:secondScreenController animated:NO];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return transitionAnimation;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    if(interactiveTransition)
        return percentDrivenInteractiveTransition;
    else
        return nil;
}

@end