//
//  NZDetailViewController.m
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 06.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import "NZDetailViewController.h"

@interface NZDetailViewController ()
- (void)configureView;
@end

@implementation NZDetailViewController

@synthesize nzPOI;

- (void)setDetailIndex:(NSInteger)newDetailIndex
{

    _detailIndex = newDetailIndex;

    [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    NSMutableArray *currentArray = [nzPOI objectAtIndex:_detailIndex];
    self.detailDescriptionLabel.text = [currentArray objectAtIndex:0];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nzPOI = [[NSMutableArray alloc] initWithCapacity: 3];
    
    [nzPOI insertObject:[NSMutableArray arrayWithObjects:@"Mt. Maunganui",[NSNumber numberWithFloat:0.7],[NSNumber numberWithFloat:0.28],nil] atIndex:0];
    [nzPOI insertObject:[NSMutableArray arrayWithObjects:@"Karikari",[NSNumber numberWithFloat:0.69],[NSNumber numberWithFloat:0.23],nil] atIndex:1];
    [nzPOI insertObject:[NSMutableArray arrayWithObjects:@"Blue Pools",[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:0.3],nil] atIndex:2];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
