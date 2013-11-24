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
}

- (void)awakeFromNib
{
    cells = [[NSMutableArray alloc] init];
}

- (void)populatePopUpDetailView:(NSMutableArray *)dataSource
{
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * dataSource.count, scrollView.frame.size.height*2)];
    for(int i = 0; i < dataSource.count; i ++)
    {
        PopUpDetailCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PopUpDetailCell" owner:self options:nil] lastObject];
        [scrollView addSubview:cell];
        cell.center = CGPointMake(scrollView.center.x + (i * scrollView.frame.size.width), scrollView.center.y + scrollView.frame.size.height);
        [cells addObject:cell];
        cell.tag = i;
    }
    int currentlyDisplayedItem = [self.delegate currentlyDisplayedItem];
    [scrollView setContentOffset:CGPointMake(currentlyDisplayedItem * scrollView.frame.size.width, scrollView.frame.size.height)];
}

- (void)populateGridDetailCell:(GridItem *)gridItem
{
    PopUpDetailCell *cell = [cells objectAtIndex:gridItem.number];
    if(cell.imageView.image == nil)
    {
        cell.imageView.image = gridItem.image;
        cell.titleLabel.text = gridItem.title;
        cell.imageView.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            cell.imageView.alpha = 1;
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    int displayedItem = (int)(_scrollView.contentOffset.x/_scrollView.frame.size.width);
    [self.delegate didDisplayItem:displayedItem];

    if(_scrollView.contentOffset.y < scrollView.frame.size.height)
    {
        [self.delegate didEndDraggingScrollView:YES];
    }
    else
    {
        [self.delegate didEndDraggingScrollView:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if(_scrollView.contentOffset.y < scrollView.frame.size.height)
    {
        [self.delegate didDragScrollViewDown:(scrollView.frame.size.height - _scrollView.contentOffset.y)/scrollView.frame.size.height];
    }
}

@end