//
//  NZDetailViewController.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 06.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZDetailViewController : UIViewController

@property (assign, nonatomic) NSInteger detailIndex;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (nonatomic, strong) NSMutableArray *nzPOI;

@end
