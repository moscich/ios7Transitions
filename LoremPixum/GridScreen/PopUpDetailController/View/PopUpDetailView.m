//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PopUpDetailView.h"
#import "PopUpDetailCell.h"
#import "GridItem.h"


@implementation PopUpDetailView {
    PopUpDetailCell *popUpDetailCell;
}

- (void)awakeFromNib
{
    cells = [[NSMutableArray alloc] init];
}

- (void)populatePopUpDetailView:(NSMutableArray *)dataSource
{
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * dataSource.count, scrollView.frame.size.height)];
    for(int i = 0; i < dataSource.count; i ++)
    {
        PopUpDetailCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PopUpDetailCell" owner:self options:nil] lastObject];
        [scrollView addSubview:cell];
        cell.center = CGPointMake(scrollView.center.x + (i * scrollView.frame.size.width), scrollView.center.y);
        [cells addObject:cell];
        cell.tag = i;
    }
    int currentlyDisplayedItem = [self.delegate currentlyDisplayedItem];
    [scrollView setContentOffset:CGPointMake(currentlyDisplayedItem * scrollView.frame.size.width, 0)];
}

- (void)populateGridDetailCell:(GridItem *)gridItem
{
    PopUpDetailCell *cell = [cells objectAtIndex:gridItem.number];
    cell.imageView.image = gridItem.image;
}


@end