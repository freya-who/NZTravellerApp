//
//  InfoViewController.m
//  Aotearoa
//
//  Created by Frederike Schmitz on 14.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.infoText.text = @"Hallo Gabi, Hallo Peter,\nich habe euch lieb!\n\nSo, das war erst mal das wichtigste. Jetzt zu Neuseeland.";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
