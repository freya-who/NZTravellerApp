//
//  ImageScrollViewController.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 11.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, copy) NSString *imgName;

@end
