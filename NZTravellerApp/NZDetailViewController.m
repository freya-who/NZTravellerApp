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
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)configureView;

@end

@implementation NZDetailViewController

@synthesize nzTravellerDetail, nzTravellerPOI;
@synthesize photoView;

- (void)setDetailIndex:(NSInteger)newDetailIndex
{

    _detailIndex = newDetailIndex;

    //[self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    NZTravellerPOI* poi = [nzTravellerPOI objectAtIndex:_detailIndex];
    NZTravellerDetails* detail = [nzTravellerDetail objectAtIndex:_detailIndex];
    
    self.detailDescriptionLabel.text = detail.descrText;
    self.title = poi.name;
    

    self.images = [[NSMutableArray alloc] init];
    _nameArray = [detail.photoName componentsSeparatedByString:@","];
    
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
            int n = [self.images count];
            for (int i=0; i<n; i++) {
                
                UIButton *newPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
                [newPhoto setImage:[self.images objectAtIndex:i] forState:UIControlStateNormal];
                float b = wP/(n*10);
                float w = (wP - (n-1)*b)/n;
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
}

- (void)pressedImage:(id)sender {
    [self performSegueWithIdentifier:@"photoSegue" sender:sender];
    //perform segue
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    
    //self.photoView = [[UIView alloc] initWithFrame:CGRectMake(20, 300, 280, 156)];
    //[self.view addSubview:photoView];
    
    
    /*
    NZTravellerPOI* poi = [nzTravellerPOI objectAtIndex:_detailIndex];
    NZTravellerDetails* detail = [nzTravellerDetail objectAtIndex:_detailIndex];
    
    self.detailDescriptionLabel.text = detail.descrText;
    self.title = poi.name;
    
    
    self.images = [[NSMutableArray alloc] init];
    _nameArray = [detail.photoName componentsSeparatedByString:@","];
    for (int i=0; i<[_nameArray count]; i++) {
        NSString *imgName = [_nameArray objectAtIndex:i];
        UIImage *img = [UIImage imageNamed:imgName];
        [self.images addObject:img];
    }
    */
    /*
     float hP = self.photoView.frame.size.height;
     float wP = self.photoView.frame.size.width;
     float xP = self.photoView.frame.origin.x;
     float yP = self.photoView.frame.origin.y;
     */
    
    /*
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HaastHighway.JPG"]];
    //[imgV setFrame:CGRectInset(self.photoView.bounds, 0, 0)];
    imgV.frame = self.photoView.bounds;
    UIButton *newPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [newPhoto setImage:[self.images objectAtIndex:0] forState:UIControlStateNormal];
    newPhoto.frame = self.photoView.frame;
    [self.photoView addSubview:imgV];
    */

    
    NSLog(@"%@", NSStringFromCGRect(self.photoView.frame));
    NSLog(@"%@", NSStringFromCGRect(self.photoView.bounds));
    
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
