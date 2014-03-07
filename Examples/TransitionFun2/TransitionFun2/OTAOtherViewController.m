//
//  OTAOtherViewController.m
//  TransitionFun2
//
//  Created by Ari Braginsky on 3/6/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "UIViewController+ECSlidingViewController.h"

#import "OTAOtherViewController.h"

@interface OTAOtherViewController ()

@end

@implementation OTAOtherViewController

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
    // Do any additional setup after loading the view from its nib.
	
    UIBarButtonItem *hamburgerButton = [[UIBarButtonItem alloc] initWithTitle:@"Ham" style:UIBarButtonItemStylePlain target:self action:@selector(showHamburgerMenu:)];
    self.navigationItem.title = @"Other View";
    self.navigationItem.leftBarButtonItem = hamburgerButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showHamburgerMenu:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
