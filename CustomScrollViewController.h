//
//  CustomScrollViewController.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 01.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIButton *buttonMtM;
    IBOutlet UIButton *buttonKari;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

-(IBAction)pressedMtM:(id)sender;
-(IBAction)pressedKari:(id)sender;

@end