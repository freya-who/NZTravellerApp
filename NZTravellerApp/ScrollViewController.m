//
//  ScrollViewController.m
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 01.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import "ScrollViewController.h"

@implementation ScrollViewContainer

@synthesize scrollView = _scrollView;

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return _scrollView;
    }
    return view;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
