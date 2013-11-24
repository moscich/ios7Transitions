//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PopUpDetailController.h"
#import "GridScreenModelProtocol.h"
#import "PopUpDetailModel.h"
#import "GridItem.h"
#import "PopUpDetailView.h"
#import "GridToDetailAnimation.h"


@implementation PopUpDetailController {
    int currentlyDisplayedGridItem;
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
}

- (id)initWithNibName:(NSString *)nibNameOrNil gridItem:(int)gridItem
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self)
    {
        currentlyDisplayedGridItem = gridItem;
    }
    return self;
}

- (void)viewDidLoad
{
    _popUpDetailModel.delegate = self;

    PopUpDetailView *view = (PopUpDetailView *)self.view;
    view.delegate = self;
    [view populatePopUpDetailView:[self.delegate loadedGridItems]];

    [self requestNearGridItems:currentlyDisplayedGridItem];
}

- (void)didReceiveGridItem:(GridItem *)gridItem
{
    NSMutableArray *dataSource = [self.delegate loadedGridItems];
    GridItem *savedGridItem = [dataSource objectAtIndex:gridItem.number];
    GridItem *mergedGridItem = [self.delegate mergeGridItems:savedGridItem secondGridItem:gridItem];
    [dataSource replaceObjectAtIndex:gridItem.number withObject:mergedGridItem];

    PopUpDetailView *view = (PopUpDetailView *)self.view;
    [view populateGridDetailCell:mergedGridItem];
}

- (int)currentlyDisplayedItem
{
    return currentlyDisplayedGridItem;
}

- (void)didDisplayItem:(int)item
{
    currentlyDisplayedGridItem = item;
    [self requestNearGridItems:currentlyDisplayedGridItem];
}

- (void)didDragScrollViewDown:(float)percent
{
    if(percentDrivenInteractiveTransition == nil)
        percentDrivenInteractiveTransition = [self.delegate startPopAnimation];

    [percentDrivenInteractiveTransition updateInteractiveTransition:percent];
}

- (void)didEndDraggingScrollView:(BOOL)finished
{
    if(percentDrivenInteractiveTransition != nil)
    {
        if(finished)
        {
            [percentDrivenInteractiveTransition finishInteractiveTransition];
        }
        else
        {
            [percentDrivenInteractiveTransition cancelInteractiveTransition];
        }

        percentDrivenInteractiveTransition = nil;
    }
}

- (void)requestNearGridItems:(int)item
{
    NSMutableArray *dataSource = [self.delegate loadedGridItems];
    for(int i = item - 1 >= 0 ? item -1 : 0; i <= item + 1 && i < dataSource.count; i++)
    {
        GridItem *gridItem = [dataSource objectAtIndex:i];
        if(gridItem.image == nil)
            [_popUpDetailModel requestGridItem:i];
        else
        {
            PopUpDetailView *view = (PopUpDetailView *)self.view;
            [view populateGridDetailCell:gridItem];
        }
    }
}

@end