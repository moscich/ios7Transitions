//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class DetailView;
@class SecondScreenImagePack;

@protocol FirstViewDelegate

- (void)navigateToSecondView:(SecondScreenImagePack *)imagePack;
- (void)didSelectRowWithFrame:(CGRect)frame;

@end

@interface FirstView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataSource;
    NSMutableDictionary *croppedImages;
    IBOutlet UITableView *tableView;
}

@property (nonatomic, assign) NSObject <FirstViewDelegate> *delegate;

- (void)populateView:(UIImage *)image;

@end