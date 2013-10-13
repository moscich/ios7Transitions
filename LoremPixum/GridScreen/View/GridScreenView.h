//
// Created by Marek Mościchowski on 11.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class GridCellView;
@class GridItem;

@protocol GridScreenViewDelegate
- (void)gridItemWasSelected:(int)gridItem;
@end

@interface GridScreenView : UIView
{
    NSMutableArray *cells;
}

@property (nonatomic, assign) id <GridScreenViewDelegate> delegate;

- (void)populateView:(NSMutableArray *)dataSource;
- (void)populateGridCell:(GridItem *)gridItem;

@end