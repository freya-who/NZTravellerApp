//
//  NZDetailViewController.m
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 06.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import "NZDetailViewController.h"
#import "NZTravellerPOI.h" //DB
#import "NZTravellerDetails.h" //DB
#import "ImageScrollViewController.h"

@interface NZDetailViewController ()

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *coordsArray;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)configureView;

@end

@implementation NZDetailViewController

@synthesize nzTravellerDetail, nzTravellerPOI;
@synthesize photoView, ratingView, coordLabel;

- (void)setDetailIndex:(NSInteger)newDetailIndex
{

    _detailIndex = newDetailIndex;

    //[self configureView];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    /* return (interfaceOrientation == UIIinterfaceOrientationPortrait || interfaceOrientation == UIIinterfaceOrientationLandscapeLeft || interfaceOrientation == UIIinterfaceOrientationLandscapeRight); */ //GET RID OF ALL THIS CRAP
    return true; //do this instead, and if this doesn't work, try return YES;
}


- (void)configureView
{
    // Update the user interface for the detail item.
    NZTravellerPOI* poi = [nzTravellerPOI objectAtIndex:_detailIndex];
    NZTravellerDetails* detail = [nzTravellerDetail objectAtIndex:_detailIndex];
    
    self.detailDescriptionLabel.text = detail.descrText;
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType hasPrefix:@"iPhone"])
    {
        self.detailDescriptionLabel.font = [UIFont fontWithName:@"arial" size:14];
    }
    else {
        self.detailDescriptionLabel.font = [UIFont fontWithName:@"arial" size:24];
    }
    //NSRange range = NSMakeRange(0,1);
    //[self.detailDescriptionLabel scrollRangeToVisible:range];
    self.title = poi.name;
    

    self.images = [[NSMutableArray alloc] init];
    _nameArray = [detail.photoName componentsSeparatedByString:@","];
    
    //set images
    if (![[_nameArray objectAtIndex:0] isEqualToString:@""]) {
        for (int i=0; i<[_nameArray count]; i++) {
            NSString *imgName = [_nameArray objectAtIndex:i];
            UIImage *img = [UIImage imageNamed:imgName];
            [self.images addObject:img];
        }
        
        float hP = self.photoView.frame.size.height;
        float wP = self.photoView.frame.size.width;
        
        if ([self.images count]==1) {
            UIButton *newPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
            [newPhoto setImage:[self.images objectAtIndex:0] forState:UIControlStateNormal];
            float x = (wP - hP)/2.0;
            newPhoto.frame = CGRectMake(x, 0, hP, hP);
            newPhoto.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            newPhoto.tag = 0;
            [newPhoto addTarget:self action:@selector(pressedImage:) forControlEvents:UIControlEventTouchUpInside];
            [self.photoView addSubview:newPhoto];
        }
        
        else {
            unsigned long n = [self.images count];
            for (int i=0; i<n; i++) {
                
                UIButton *newPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
                [newPhoto setImage:[self.images objectAtIndex:i] forState:UIControlStateNormal];
                float b = wP/(n*10);
                float w = MIN((wP - (n-1)*b)/n,hP);
                float x;
                if (i==0) {x=0;}
                else x = i*((wP+b)/n);
                float y = hP - w;
                newPhoto.frame = CGRectMake(x, y, w, w);
                newPhoto.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                newPhoto.tag = i;
                [newPhoto addTarget:self action:@selector(pressedImage:) forControlEvents:UIControlEventTouchUpInside];
                [self.photoView addSubview:newPhoto];
            }
        }
    }
    
    
    //set ratings image
    for (int i=0; i<5; i++) {
        float wS = self.ratingView.frame.size.width;
        float b = wS/30;
        float w = (wS - 4*b)/5;
        float x = i*((wS+b)/5);
        UIImageView *star;
        
        if (i<[detail.rating intValue]) {
            star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Star.png"]];
        }
        else star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"starEmpty.png"]];
    
        star.frame = CGRectMake(x, 0, w, w);
        [self.ratingView addSubview:star];

    }

    _coordsArray = [detail.coordinates componentsSeparatedByString:@","];
    float xCoord = [[_coordsArray objectAtIndex:0] floatValue];
    float yCoord = -[[_coordsArray objectAtIndex:1] floatValue];
    
    NSString *coordText = [NSString stringWithFormat:@"%.05f S, %.05f E", yCoord, xCoord];
    self.coordLabel.text = coordText;
    

    //poiLabel.font = [poiLabel.font fontWithSize:fontsize];

}


- (void)pressedImage:(id)sender {
    [self performSegueWithIdentifier:@"photoSegue" sender:sender];
    //perform segue
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"NZTravellerPOI" inManagedObjectContext:_managedObjectContext];
    NSEntityDescription *entityDetail = [NSEntityDescription
                                   entityForName:@"NZTravellerDetails" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.nzTravellerPOI = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //self.title = @"POI New Zealand";
    
    [fetchRequest setEntity:entityDetail];
    self.nzTravellerDetail = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self configureView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"photoSegue"]) {
        ImageScrollViewController *isvc = [segue destinationViewController];
        NSInteger tagIndex = [(UIButton *)sender tag];
        NSString *photoString = [_nameArray objectAtIndex:tagIndex];
        
        [isvc setImgName:photoString];
    }
}


@end
