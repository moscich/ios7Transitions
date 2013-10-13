//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GridScreenModel.h"
#import "LoremPixumImporter.h"
#import "LoremPixumImporterProtocol.h"
#import "GridItem.h"


@implementation GridScreenModel {

}
@synthesize delegate;

- (id)initWithLorem:(id <LoremPixumImporterProtocol>)lorem
{
    self = [super init];

    if(self)
    {
        loremPixum = lorem;
    }

    return self;
}

- (void)requestGridItemsFrom:(int)from to:(int)to
{
    for(int i = from; i < to; i++)
    {
        [self requestGridItem:i];
    }
}

- (void)requestGridItem:(int)number
{
    [loremPixum getImageWithWidth:200 withHeight:160 withIdentifier:number onCompletion:^(UIImage *image)
    {
        GridItem *gridItem = [[GridItem alloc] init];
        gridItem.thumbnail = image;
        gridItem.title = [NSString stringWithFormat:@"item %d", number];
        gridItem.number = number;

        [self.delegate didReceiveGridItem:gridItem];
    }];
}

@end