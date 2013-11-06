//
//  CustomScrollViewController.m
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 01.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import "CustomScrollViewController.h"
#import "NZDetailViewController.h"
#import "NZTravellerPOI.h" //DB
//#import "NZTravellerDetails.h"

@interface CustomScrollViewController ()

@property (nonatomic, strong) UIView *containerView;

//@property (nonatomic, strong) UIButton *buttonMtM;
//@property (nonatomic, strong) UIButton *buttonKari;

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;

@end

@implementation CustomScrollViewController

@synthesize scrollView = _scrollView;
@synthesize containerView = _containerView;
//@synthesize buttonMtM, buttonKari;
@synthesize managedObjectContext; //DB
@synthesize nzTravellerPOI; //DB
@synthesize nzPOI;
@synthesize nzMap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)pressedStar:(id)sender {
    [self performSegueWithIdentifier:@"detailSegue" sender:sender];
    //perform segue
}


- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.containerView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.containerView.frame = contentsFrame;
}


- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:self.containerView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}


- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}


- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

CGPoint CGPointAdd(CGPoint p1, CGPoint p2)
{
    //simple function to add cgpoints
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

- (void)makeButtons:(NSMutableArray *)myarray {
    //function that adds buttons to container view with information from array (later Core Data)
    
    UIImage *starIm = [UIImage imageNamed:@"Star.png"];
    
    CGFloat x = nzMap.size.width;
    CGFloat y = nzMap.size.height;
    
    CGSize labelSize = CGSizeMake(x/3, y/60);
    CGSize starSize = CGSizeMake(x/60, x/60);
    
    CGPoint offset = CGPointMake(x*0.02, -y*0.001);
    
    int fontsize = (int)x/80;

    NSMutableArray *currentPOI;
    
    for (int i=0; i<[myarray count]; i++) {
        currentPOI = [myarray objectAtIndex:i];
        float xLoc = [[currentPOI objectAtIndex:1] floatValue];
        float yLoc = [[currentPOI objectAtIndex:2] floatValue];
        CGPoint myPoint = CGPointMake(x*xLoc, y*yLoc);
        UILabel *poiLabel = [[UILabel alloc] initWithFrame:(CGRect){.origin = CGPointAdd(myPoint, offset),.size = labelSize}];
        poiLabel.font = [poiLabel.font fontWithSize:fontsize];
        poiLabel.text = [currentPOI objectAtIndex:0];
        [self.containerView addSubview:poiLabel];
        
        UIButton *poiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [poiButton setImage:starIm forState:UIControlStateNormal];
        poiButton.frame = (CGRect){.origin = myPoint,.size = starSize};
        poiButton.tag = i;
        [poiButton addTarget:self action:@selector(pressedStar:) forControlEvents:UIControlEventTouchUpInside];
        [self.containerView addSubview:poiButton];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"NZTravellerPOI" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.nzTravellerPOI = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.title = @"POI New Zealand";
     */
    
    
    //setUp Matrix that holds info for now, to be replaced with Core Data
    nzPOI = [[NSMutableArray alloc] initWithCapacity: 3];
    
    [nzPOI insertObject:[NSMutableArray arrayWithObjects:@"Mt. Maunganui",[NSNumber numberWithFloat:0.7],[NSNumber numberWithFloat:0.28],nil] atIndex:0];
    [nzPOI insertObject:[NSMutableArray arrayWithObjects:@"Karikari",[NSNumber numberWithFloat:0.69],[NSNumber numberWithFloat:0.23],nil] atIndex:1];
    [nzPOI insertObject:[NSMutableArray arrayWithObjects:@"Blue Pools",[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:0.3],nil] atIndex:2];
    
    
    //setup container view that will hold map image, labels and buttons
    nzMap = [UIImage imageNamed:@"NewZealandMapKMM.png"];
    
    CGSize containerSize = nzMap.size;
    
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize}];
    [self.scrollView addSubview:self.containerView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:nzMap];
    imageView.center = CGPointMake(nzMap.size.width/2.0f, nzMap.size.height/2.0f);
    [self.containerView addSubview:imageView];
    
    //add buttons and labels to container view
    [self makeButtons:nzPOI];
    
    
    //TapRecognizer
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = containerSize;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        NZDetailViewController *vc = [segue destinationViewController];
        NSInteger tagIndex = [(UIButton *)sender tag];
        
        [vc setDetailIndex:tagIndex];
    }
}

@end