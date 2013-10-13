//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class GridItem;

@protocol GridScreenModelDelegate

- (void)didReceiveGridItem:(GridItem *)gridItem;

@end

@protocol GridScreenModelProtocol <NSObject>
@property (nonatomic, assign) NSObject <GridScreenModelDelegate> *delegate;

- (void)requestGridItem:(int)number;
- (void)requestGridItemsFrom:(int)from to:(int)to;

@end