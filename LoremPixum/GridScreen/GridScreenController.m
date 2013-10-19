//
// Created by Marek Mościchowski on 11.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GridScreenView.h"
#import "GridScreenController.h"
#import "PopUpDetailController.h"
#import "GridToDetailAnimation.h"
#import "GridScreenModelProtocol.h"
#import "GridItem.h"
#import "PopUpDetailModel.h"
#import "LoremPixumImporter.h"


@implementation GridScreenController {
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;

}

- (void)viewDidLoad
{
    dataSource = [[NSMutableArray alloc] init];
    _gridScreenModel.delegate = self;
    for(int i = 0;i < 10 ; i++)
    {
        GridItem *gridItem = [[GridItem alloc] init];
        gridItem.number = i;
        [dataSource addObject:gridItem];
    }
    [_gridScreenModel requestGridItemsFrom:0 to:10];
    [_gridScreenModel requestBackgroundImage];
    GridScreenView *view = (GridScreenView *)self.view;
    [view populateView:dataSource];
    view.delegate = self;

    percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[GridToDetailAnimation alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[GridToDetailAnimation alloc] init];
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return percentDrivenInteractiveTransition;
}

- (void)didReceiveGridItem:(GridItem *)gridItem
{
    GridItem *savedGridItem = [dataSource objectAtIndex:gridItem.number];
    GridItem *mergedGridItem = [self mergeGridItems:savedGridItem secondGridItem:gridItem];
    [dataSource replaceObjectAtIndex:gridItem.number withObject:mergedGridItem];
    GridScreenView *view = (GridScreenView *)self.view;
    [view populateGridCell:mergedGridItem];
}

- (void)didReceiveBackgroundImage:(UIImage *)backgroundImage
{
    GridScreenView *view = (GridScreenView *)self.view;
    [view populateViewsBackground:backgroundImage];
}

- (void)gridItemWasSelected:(int)gridItem
{
    PopUpDetailController *detailController = [[PopUpDetailController alloc] initWithNibName:@"PopUpDetailView" gridItem:gridItem];
    detailController.popUpDetailModel = [[PopUpDetailModel alloc] initWithLorem:[[LoremPixumImporter alloc] init]];
    detailController.modalPresentationStyle = UIModalPresentationCustom;
    detailController.delegate = self;
    if([detailController respondsToSelector:@selector(setTransitioningDelegate:)])
        detailController.transitioningDelegate = self;
    [self presentViewController:detailController animated:YES completion:nil];
}

- (NSMutableArray *)loadedGridItems {
    return dataSource;
}

- (GridItem *)mergeGridItems:(GridItem *)gridItem secondGridItem:(GridItem *)secondGridItem
{
    GridItem *mergedGridItem = [[GridItem alloc] init];

    mergedGridItem.image = gridItem.image != nil ? gridItem.image : secondGridItem.image;
    mergedGridItem.thumbnail = gridItem.thumbnail != nil ? gridItem.thumbnail : secondGridItem.thumbnail;
    mergedGridItem.title = gridItem.title != nil ? gridItem.title : secondGridItem.title;
    mergedGridItem.description = gridItem.description != nil ? gridItem.description : secondGridItem.description;
    mergedGridItem.number = gridItem.number != 0 ? gridItem.number : secondGridItem.number;

    return mergedGridItem;
}

- (UIPercentDrivenInteractiveTransition *)startPopAnimation
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    return percentDrivenInteractiveTransition;
}


@end