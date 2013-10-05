//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MainContainerView.h"


@implementation MainContainerView {

}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitedView = [super hitTest:point withEvent:event];
    if (point.x < 200 - _scrollView.contentOffset.x)
    {
        return [_menuView hitTest:point withEvent:event];
    }

    return hitedView;
}

@end