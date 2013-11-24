//
// Created by Marek Mościchowski on 09.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

enum LowerUpperView
{
    LowerImageView = -1,
    UpperImageView = 1
};

@protocol WelcomeScreenViewDelegate
-(void)didSelect:(enum LowerUpperView)lowerUpperView;
@end

@interface WelcomeScreenView : UIView

@property (nonatomic, assign) NSObject <WelcomeScreenViewDelegate> *delegate;
@property (nonatomic, retain) IBOutlet UIImageView *upperImageView;
@property (nonatomic, retain) IBOutlet UIImageView *lowerImageView;
@property (nonatomic, assign) int cuttingLineHeight;

- (void)populateViewWithLowerImage:(UIImage *)lowerImage;
- (void)populateViewWithUpperImage:(UIImage *)upperImage;
@end