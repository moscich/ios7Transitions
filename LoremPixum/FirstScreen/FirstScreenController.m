//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FirstScreenController.h"
#import "LoremPixumImporter.h"
#import "SecondScreenController.h"


@implementation FirstScreenController
{

}

- (void)viewDidLoad
{

    FirstView *_firstView = (FirstView *)self.view;
    _firstView.delegate = self;

    LoremPixumImporter *loremPixumImporter = [[LoremPixumImporter alloc] init];
    int width = 640;
    int height = 1136;

    for(int i = 0; i < 10; i++)
    {
        [loremPixumImporter getImageWithWidth:width withHeight:height onCompletion:^(UIImage *image)
        {
            FirstView *firstView = (FirstView *)self.view;
            if(image != nil)
                [firstView populateView:image];
        }];
    }
}

- (void)loadView
{
    [super loadView];
}

- (void)navigateToSecondView:(SecondScreenImagePack *)imagePack
{
    SecondScreenController *secondScreenController = [[SecondScreenController alloc] initWithNibName:@"SecondScreenView" bundle:nil];
    [secondScreenController setImagePack:imagePack];
    [self.navigationController pushViewController:secondScreenController animated:NO];
}

@end