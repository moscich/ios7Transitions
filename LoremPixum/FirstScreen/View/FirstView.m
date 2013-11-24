//
// Created by Marek Mościchowski on 03.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "FirstView.h"
#import "ImageViewCell.h"
#import "SecondScreenImagePack.h"


@implementation FirstView {

}

- (void)awakeFromNib {
    dataSource = [[NSMutableArray alloc] init];
    croppedImages = [[NSMutableDictionary alloc] init];
}

- (void)populateView:(UIImage *)image
{
    [dataSource addObject:image];
    [tableView reloadData];
}

- (void)selectRowAtPoint:(CGPoint)point
{
    for(int index = 0; index < [self tableView:tableView numberOfRowsInSection:1]; index++)
    {
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:1]];
        CGRect frame = [tableView convertRect:rectInTableView toView:self];

        if(CGRectContainsPoint(frame, point))
        {
            [self tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:1]];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 1;
    else
        return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 120;
    else
        return 100;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section == 0)
        return [self headerCellForTableView:_tableView];
    else
        return [self tableView:_tableView imageCellForRow:indexPath.row];
}

- (ImageViewCell *)tableView:(UITableView *)_tableView imageCellForRow:(int)row
{
    ImageViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"ImageViewCell"];

    [_tableView registerNib:[UINib nibWithNibName:@"ImageViewCell" bundle:nil]
     forCellReuseIdentifier:@"ImageViewCell"];

    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.horizontalImageView.image = [self croppedImageForRow:row];

    return cell;
}

- (UITableViewCell *)headerCellForTableView:(UITableView *)_tableView
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"FirstViewHeaderCell"];

    [_tableView registerNib:[UINib nibWithNibName:@"FirstViewHeaderCell" bundle:nil]
     forCellReuseIdentifier:@"FirstViewHeaderCell"];

    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstViewHeaderCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rectInTableView = [_tableView rectForRowAtIndexPath:indexPath];
    CGRect frame = [_tableView convertRect:rectInTableView toView:self];

    CGRect croppedFrame = CGRectMake(frame.origin.x, frame.origin.y +2, frame.size.width, frame.size.height -4);

    [self.delegate didSelectRowWithFrame:croppedFrame withImage:[dataSource objectAtIndex:indexPath.row]];
}

- (UIImage *)croppedImageForRow:(int)row
{
    NSString *key = [NSString stringWithFormat:@"%d",row];
    if([croppedImages objectForKey:key])
    {
        return [croppedImages objectForKey:key];
    }
    UIImage *croppedImage = [self cropImage:[dataSource objectAtIndex:row] withRect:CGRectMake(0, 234*2 , 640, 196)];
    [croppedImages setObject:croppedImage forKey:key];
    return croppedImage;
}

- (UIImage *)cropImage:(UIImage *)image withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    [UIImage imageWithCGImage:imageRef];
    return [UIImage imageWithCGImage:imageRef];
}

@end