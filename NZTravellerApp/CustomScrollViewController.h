//
//  CustomScrollViewController.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 01.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollViewController : UIViewController <UIScrollViewDelegate> {
    UIImage *nzMap;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext; //DB
@property (nonatomic, strong) NSArray *nzTravellerPOI;
@property (nonatomic, strong) UIImage *nzMap;

@end