//
// Created by Marek Mościchowski on 04.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class SecondScreenImagePack;


@interface SecondScreenController : UIViewController
{
    SecondScreenImagePack *imagePack;
}
- (void)setImagePack:(SecondScreenImagePack *)_imagePack;
@end