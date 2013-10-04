//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FirstView.h"
#import "ImageViewCell.h"
#import "UIImageView+AFNetworking.h"


@implementation FirstView {

}

- (void)awakeFromNib {
    dataSource = [[NSMutableArray alloc] init];

}

- (void)populateView:(UIImage *)image
{
    [dataSource addObject:image];
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ImageViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"ImageViewCell"];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageViewCell" owner:self options:nil] lastObject];
        NSUInteger row = (NSUInteger)indexPath.row;
        cell.srakaNaCiescie.image = [self cropImage:[dataSource objectAtIndex:row]];
    }

    return cell;
}

- (UIImage *)cropImage:(UIImage *)image
{
    CGRect rect = CGRectMake(0, 234*2 , 640, 200);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRef];
}

@end