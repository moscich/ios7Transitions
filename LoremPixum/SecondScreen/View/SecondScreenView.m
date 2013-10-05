//
// Created by Marek Mościchowski on 04.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SecondScreenView.h"
#import "SecondScreenImagePack.h"


@implementation SecondScreenView {

}
- (void)populateViewWithImagePack:(SecondScreenImagePack *)imagePack
{
    self.backgroundImageView.image = imagePack.backgroundImage;
    self.upperImageView.image = imagePack.upperImage;
    self.lowerImageView.image = imagePack.lowerImage;
    self.upperImageView.frame = CGRectMake(self.upperImageView.frame.origin.x, self.upperImageView.frame.origin.y, self.upperImageView.image.size.width, self.upperImageView.image.size.height);
    self.lowerImageView.frame = CGRectMake(
            0,
            self.frame.size.height - self.lowerImageView.image.size.height,
            self.frame.size.width,
            self.lowerImageView.image.size.height);
    [self performSelector:@selector(openView) withObject:nil afterDelay:0.1];
    self.backgroundImageView.center = CGPointMake(self.upperImageView.center.x, self.upperImageView.frame.size.height + 50);
}

- (void)openView
{
    NSLog(@"frame heiht = %f", self.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.upperImageView.frame = CGRectMake(0, -self.upperImageView.frame.size.height, self.upperImageView.frame.size.width, self.upperImageView.frame.size.height);
        self.lowerImageView.frame = CGRectMake(0, self.frame.size.height, self.lowerImageView.frame.size.width, self.lowerImageView.frame.size.height);
        self.backgroundImageView.center = self.center;
    }];
}

@end