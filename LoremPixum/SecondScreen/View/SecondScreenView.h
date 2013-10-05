//
// Created by Marek Mościchowski on 04.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class SecondScreenImagePack;


@interface SecondScreenView : UIView
{
}

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, retain) IBOutlet UIImageView *upperImageView;
@property (nonatomic, retain) IBOutlet UIImageView *lowerImageView;

- (void)populateViewWithImagePack:(SecondScreenImagePack *)imagePack;

@end