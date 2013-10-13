//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol LoremPixumImporterProtocol <NSObject>

- (void)getImageWithWidth:(int)width withHeight:(int)height onCompletion:(void (^)(UIImage *))completion;
- (void)getImageWithWidth:(int)width withHeight:(int)height withIdentifier:(int)identifier onCompletion:(void (^)(UIImage *))completion;

@end