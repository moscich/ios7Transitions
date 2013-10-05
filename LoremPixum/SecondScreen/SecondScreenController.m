//
// Created by Marek Mościchowski on 04.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SecondScreenController.h"
#import "SecondScreenImagePack.h"
#import "SecondScreenView.h"


@implementation SecondScreenController
{

}

- (void)setImagePack:(SecondScreenImagePack *)_imagePack
{
    imagePack = _imagePack;
}

- (void)viewDidLoad
{
    [((SecondScreenView *) self.view) populateViewWithImagePack:imagePack];
}

@end