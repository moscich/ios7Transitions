//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "PopUpDetailModel.h"
#import "PopUpDetailView.h"

@protocol GridScreenModelProtocol;
@class PopUpDetailModel;
@class GridItem;

@protocol PopUpDetailControllerDelegate
- (NSMutableArray *)loadedGridItems;
- (GridItem *)mergeGridItems:(GridItem *)gridItem secondGridItem:(GridItem *)secondGridItem;
@end

@interface PopUpDetailController : UIViewController <PopUpDetailModelDelegate, PopUpDetailViewDelegate>

@property (nonatomic, assign) id <PopUpDetailControllerDelegate> delegate;
@property (nonatomic, retain) PopUpDetailModel *popUpDetailModel;

- (id)initWithNibName:(NSString *)nibNameOrNil gridItem:(int)gridItem;
@end