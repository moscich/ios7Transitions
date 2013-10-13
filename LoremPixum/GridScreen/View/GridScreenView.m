//
// Created by Marek Mościchowski on 11.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GridScreenView.h"
#import "GridCellView.h"
#import "GridItem.h"


@implementation GridScreenView {

}

- (void)awakeFromNib
{
    cells = [[NSMutableArray alloc] init];
}

- (void)gridItemWasSelected:(GridCellView *)buttonPressed
{
    [self.delegate gridItemWasSelected:buttonPressed.tag];
}

- (void)populateView:(NSMutableArray *)dataSource
{
    for(int i = 0;i < dataSource.count; i++)
    {
        GridCellView *gridCell = [[[NSBundle mainBundle] loadNibNamed:@"GridCellView" owner:self options:nil] lastObject];
        gridCell.center = CGPointMake( i % 2 ? self.center.x*0.5 : self.center.x*1.5, 50 + i/2*130);
        gridCell.tag = i;
        [gridCell addTarget:self action:@selector(gridItemWasSelected:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:gridCell];
        [cells addObject:gridCell];
    }
}

- (void)populateGridCell:(GridItem *)gridItem
{
    GridCellView *gridCell = [cells objectAtIndex:gridItem.number];
    gridCell.gridCellThumbnail.image = gridItem.thumbnail;
    gridCell.cellLabel.text = gridItem.title;

    gridCell.gridCellThumbnail.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        gridCell.gridCellThumbnail.alpha = 1;
    }];
}

@end