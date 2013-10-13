//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PopUpDetailModel.h"
#import "LoremPixumImporterProtocol.h"
#import "GridItem.h"


@implementation PopUpDetailModel
{

}

- (id)initWithLorem:(id <LoremPixumImporterProtocol>)lorem
{
    self = [super init];

    if(self)
    {
        loremPixum = lorem;
    }

    return self;
}

- (void)requestGridItem:(int)number
{
    [loremPixum getImageWithWidth:480 withHeight:480 withIdentifier:number onCompletion:^(UIImage *image)
    {
        GridItem *gridItem = [[GridItem alloc] init];
        gridItem.image = image;
        gridItem.description = gridItem.description;
        gridItem.number = number;
        [self.delegate didReceiveGridItem:gridItem];
    }];
}


@end