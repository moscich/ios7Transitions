//
// Created by Marek Mościchowski on 09.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WelcomeScreenView.h"


@implementation WelcomeScreenView {

}

- (void)awakeFromNib
{
    self.cuttingLineHeight = 150;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageSelected:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)imageSelected:(UITapGestureRecognizer *)tapGestureRecognizer
{
    CGPoint tapLocation = [tapGestureRecognizer locationInView:self];

    NSLog(@"y = %f  licz = %f", tapLocation.y, -15.0/16.0*tapLocation.x +150);
    if(tapLocation.y < 2*self.cuttingLineHeight/self.frame.size.width*tapLocation.x +self.center.y - self.cuttingLineHeight)
    {
        [self.delegate didSelect:UpperImageView];
    }
    else
    {
        [self.delegate didSelect:LowerImageView];
    }

}

- (UIImage *)cropImage:(UIImage *)image withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    [UIImage imageWithCGImage:imageRef];
    return [UIImage imageWithCGImage:imageRef];
}

- (void)populateViewWithLowerImage:(UIImage *)lowerImage
{
    CGRect retinaRect = CGRectMake(self.lowerImageView.frame.origin.x *2, self.lowerImageView.frame.origin.y *2, self.lowerImageView.frame.size.width *2, self.lowerImageView.frame.size.height *2);
    UIImage *croppedLowerImage = [self cropImage:lowerImage withRect:retinaRect];

    UIImage *mask = [self generateMaskFor:LowerImageView];

    self.lowerImageView.image = [self maskImage:croppedLowerImage withMask:mask ];
}

- (void)populateViewWithUpperImage:(UIImage *)upperImage
{
    CGRect retinaRect = CGRectMake(self.upperImageView.frame.origin.x *2, self.upperImageView.frame.origin.y *2, self.upperImageView.frame.size.width *2, self.upperImageView.frame.size.height *2);
    UIImage *croppedUpperImage = [self cropImage:upperImage withRect:retinaRect];

    UIImage *mask = [self generateMaskFor:UpperImageView];

    self.upperImageView.image = [self maskImage:croppedUpperImage withMask:mask];
}

- (UIImage *)generateMaskFor:(enum LowerUpperView)lowerUpperView
{
    UIImageView *imageView = lowerUpperView == LowerImageView ? self.lowerImageView : self.upperImageView;

    CGSize maskSize = CGSizeMake(imageView.frame.size.width*2, imageView.frame.size.height*2);
    UIGraphicsBeginImageContext(maskSize);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);

    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, maskSize.width, maskSize.height));

    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);

    CGPoint point = [self convertPoint:self.center toView:imageView];

    CGContextSetLineWidth(context, 1.0f);

    if(lowerUpperView == LowerImageView)
    {
        CGContextMoveToPoint(context, 0, (point.y - self.cuttingLineHeight) * 2);
        CGContextAddLineToPoint(context, 0, maskSize.height);
        CGContextAddLineToPoint(context, maskSize.width, maskSize.height);
        CGContextAddLineToPoint(context, maskSize.width, (point.y + self.cuttingLineHeight) * 2);
    }
    else
    {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, maskSize.width, 0);
        CGContextAddLineToPoint(context, maskSize.width, (point.y + self.cuttingLineHeight)*2);
        CGContextAddLineToPoint(context, 0, (point.y - self.cuttingLineHeight)*2);
    }

    CGContextFillPath(context);

    UIImage* mask = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return mask;
}

- (UIImage*) maskImage:(UIImage *) image withMask:(UIImage *) mask
{
    CGImageRef imageReference = image.CGImage;
    CGImageRef maskReference = mask.CGImage;

    CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(maskReference),
            CGImageGetHeight(maskReference),
            CGImageGetBitsPerComponent(maskReference),
            CGImageGetBitsPerPixel(maskReference),
            CGImageGetBytesPerRow(maskReference),
            CGImageGetDataProvider(maskReference),
            NULL, // Decode is null
            YES // Should interpolate
    );

    CGImageRef maskedReference = CGImageCreateWithMask(imageReference, imageMask);

    UIImage *maskedImage = [UIImage imageWithCGImage:maskedReference];

    return maskedImage;
}
@end