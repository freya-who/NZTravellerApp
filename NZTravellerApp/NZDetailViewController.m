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

@property (nonatomic, strong) NSMutableArray *pageImages;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

- (void)configureView;

@end

@implementation NZDetailViewController

@synthesize nzTravellerDetail, nzTravellerPOI;

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
    self.nameLabel.text = poi.name;
    

    self.pageImages = [[NSMutableArray alloc] init];
    _nameArray = [detail.photoName componentsSeparatedByString:@","];
    for (int i=0; i<[_nameArray count]; i++) {
        NSString *imgName = [_nameArray objectAtIndex:i];
        UIImage *img = [UIImage imageNamed:imgName];
        [self.pageImages addObject:img];
    }

    
    NSInteger pageCount = self.pageImages.count;
    
    // Set up the page control
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    
    // Set up the array to hold the views for each page
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }

    
}

- (void)pressedImage:(id)sender {
    [self performSegueWithIdentifier:@"photoSegue" sender:sender];
    //perform segue
}


- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first checking if you've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame = CGRectInset(frame, 10.0f, 0.0f);
        
        /*
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
        */
        
        UIButton *newPageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [newPageView setImage:[self.pageImages objectAtIndex:page] forState:UIControlStateNormal];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        newPageView.tag = page;
        [newPageView addTarget:self action:@selector(pressedImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
        
        /*
        UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [poiButton setImage:starIm forState:UIControlStateNormal];
        poiButton.frame = (CGRect){.origin = poiPoint,.size = starSize};
        poiButton.tag = i;
        [poiButton addTarget:self action:@selector(pressedStar:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:poiButton];
         */
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    
    [self loadVisiblePages];
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
    
    
    _scrollView.canCancelContentTouches = YES;
    
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    // Load the initial set of pages that are on screen
    [self loadVisiblePages];
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
