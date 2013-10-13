//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol LoremPixumImporterProtocol;
@class GridItem;

@protocol PopUpDetailModelDelegate
- (void)didReceiveGridItem:(GridItem *)gridItem;
@end

@interface PopUpDetailModel : NSObject
{
    id <LoremPixumImporterProtocol> loremPixum;
}

@property (nonatomic, assign) id <PopUpDetailModelDelegate> delegate;

- (id)initWithLorem:(id <LoremPixumImporterProtocol>)lorem;
- (void)requestGridItem:(int)number;

@end