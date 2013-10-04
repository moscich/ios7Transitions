//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ImageViewCell.h"


@implementation ImageViewCell {

}

- (void)awakeFromNib {
    [self.srakaNaCiescie addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bomba)]];
}

- (void)bomba
{
    NSLog(@"Gówno");
}

@end