//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "FirstView.h"

@protocol ContainerControllerProtocol;


@interface FirstScreenController : UIViewController <FirstViewDelegate, UINavigationControllerDelegate>
{
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
}

@property (nonatomic, assign) NSObject <ContainerControllerProtocol> *delegate;

@end