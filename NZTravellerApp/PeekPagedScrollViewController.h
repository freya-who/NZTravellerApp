//
//  PeekPagedScrollViewController.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 01.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeekPagedScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@end
