//
//  NZDetailViewController.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 06.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZDetailViewController : UIViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext; //DB
@property (assign, nonatomic) NSInteger detailIndex;
@property (nonatomic, strong) NSArray *nzTravellerPOI;
@property (nonatomic, strong) NSArray *nzTravellerDetail;

@property (weak, nonatomic) IBOutlet UITextView *detailDescriptionLabel;

@property (nonatomic, strong) IBOutlet UIView *photoView;
@property (nonatomic, strong) IBOutlet UIView *ratingView;

@property (nonatomic,strong) IBOutlet UITextView *coordLabel;


@end
