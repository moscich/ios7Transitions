//
// Created by Marek Mościchowski on 04.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class SecondScreenImagePack;
@class AnimateOpenImage;


@interface SecondScreenController : UIViewController <UINavigationControllerDelegate> {
    SecondScreenImagePack *imagePack;
}

@property (nonatomic, retain) AnimateOpenImage *animateOpenImage;

- (void)setImagePack:(SecondScreenImagePack *)_imagePack;
- (void)setBackgroundImage:(UIImage *)backgroundImage;

@end