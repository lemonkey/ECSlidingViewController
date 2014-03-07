//
//  OTACenterViewController.m
//  TransitionFun2
//
//  Created by Ari Braginsky on 3/6/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "UIViewController+ECSlidingViewController.h"

#import "OTACenterViewController.h"

@interface OTACenterViewController ()

@end

@implementation OTACenterViewController

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
	
    UIBarButtonItem *hamburgerButton = [[UIBarButtonItem alloc] initWithTitle:@"Ham" style:UIBarButtonItemStylePlain target:self action:@selector(showHamburgerMenu)];
    self.navigationItem.title = @"Center View";
    self.navigationItem.leftBarButtonItem  = hamburgerButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showHamburgerMenu {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
