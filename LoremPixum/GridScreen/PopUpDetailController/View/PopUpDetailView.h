//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class GridItem;

@protocol PopUpDetailViewDelegate
- (int)currentlyDisplayedItem;
- (void)didDisplayItem:(int)item;
- (void)didDragScrollViewDown:(float)percent;
- (void)didEndDraggingScrollView:(BOOL)finished;
@end

@interface PopUpDetailView : UIView <UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *cells;
}

@property (nonatomic, assign) id <PopUpDetailViewDelegate> delegate;

- (void)populatePopUpDetailView:(NSMutableArray *)gridItem;
- (void)populateGridDetailCell:(GridItem *)gridItem;

@end