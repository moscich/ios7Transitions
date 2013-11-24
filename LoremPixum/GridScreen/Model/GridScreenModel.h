//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "GridScreenModelProtocol.h"

@protocol LoremPixumImporterProtocol;


@interface GridScreenModel : NSObject <GridScreenModelProtocol>
{
    id <LoremPixumImporterProtocol> loremPixum;
}
- (id)initWithLorem:(id <LoremPixumImporterProtocol>)lorem;
@end