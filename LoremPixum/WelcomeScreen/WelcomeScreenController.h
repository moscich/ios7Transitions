//
// Created by Marek Mościchowski on 09.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "WelcomeScreenView.h"

@protocol ContainerControllerProtocol;


@interface WelcomeScreenController : UIViewController <WelcomeScreenViewDelegate>

@property (nonatomic, assign) NSObject <ContainerControllerProtocol> *delegate;

@end