//
// Created by Marek Mościchowski on 12.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface GridItem : NSObject

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) int number;
@end