
//
// Created by Marek Mościchowski on 11.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "GridScreenModelProtocol.h"
#import "GridScreenView.h"
#import "PopUpDetailController.h"

@protocol GridScreenModelProtocol;

@interface GridScreenController : UIViewController <UIViewControllerTransitioningDelegate, GridScreenModelDelegate, GridScreenViewDelegate, PopUpDetailControllerDelegate>
{
    NSMutableArray *dataSource;
}

@property (nonatomic, retain) id <GridScreenModelProtocol> gridScreenModel;

- (IBAction) buttonPressed;
@end