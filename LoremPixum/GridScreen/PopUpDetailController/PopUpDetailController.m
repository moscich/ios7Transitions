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


@implementation PopUpDetailController {
    int currentlyDisplayedGridItem;
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
    [_popUpDetailModel requestGridItem:currentlyDisplayedGridItem];

    PopUpDetailView *view = (PopUpDetailView *)self.view;
    view.delegate = self;
    [view populatePopUpDetailView:[self.delegate loadedGridItems]];
}

- (void)didReceiveGridItem:(GridItem *)gridItem
{
    NSMutableArray *dataSource = [self.delegate loadedGridItems];
    GridItem *savedGridItem = [dataSource objectAtIndex:gridItem.number];
    GridItem *mergedGridItem = [self.delegate mergeGridItems:savedGridItem secondGridItem:gridItem];
    [dataSource replaceObjectAtIndex:gridItem.number withObject:mergedGridItem];

    PopUpDetailView *view = (PopUpDetailView *)self.view;
    [view populateGridDetailCell:gridItem];
}

- (int)currentlyDisplayedItem
{
    return currentlyDisplayedGridItem;
}


@end