//
//  OTALeftViewController.m
//  TransitionFun2
//
//  Created by Ari Braginsky on 3/6/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "UIViewController+ECSlidingViewController.h"

#import "OTALeftViewController.h"
#import "OTAOtherViewController.h"

typedef enum OTAViewControllerTypes : NSInteger {
	OTAViewControllerTypeOriginalCenter,
	OTAViewControllerTypeOther
} OTAViewControllerTypes;

@interface OTALeftViewController ()
@property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@end

@implementation OTALeftViewController

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

	// we want left view to go underneath top view so that its background fills in the entire view
	//self.edgesForExtendedLayout = ...;

	// topViewController is the transitions navigation controller at this point.
    // We keep a reference to this instance so that we can go back to it without losing its state.
    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)originalCenterViewButtonTapped:(id)sender {
	[self viewButtonTappedForViewType:OTAViewControllerTypeOriginalCenter];
}

-(IBAction)otherViewButtonTapped:(id)sender {
	[self viewButtonTappedForViewType:OTAViewControllerTypeOther];
}

-(void)viewButtonTappedForViewType:(OTAViewControllerTypes)viewControllerType {
	
	// This undoes the Zoom Transition's scale because it affects the other transitions.
    // You normally wouldn't need to do anything like this, but we're changing transitions
    // dynamically so everything needs to start in a consistent state.
    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);

	switch (viewControllerType) {
		case OTAViewControllerTypeOriginalCenter: {
			
			// restore original pan gesture if user previously selected other view controller and reassigned topViewController
			if(![self.transitionsNavigationController.view.gestureRecognizers containsObject:self.slidingViewController.panGesture]) {
				[self.transitionsNavigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
			}
			
			self.slidingViewController.topViewController = self.transitionsNavigationController;
			break;
		}
		case OTAViewControllerTypeOther: {
			
			// this will destroy and recreate other view controller even if it is the current center view
			OTAOtherViewController *otherViewController = [[OTAOtherViewController alloc] initWithNibName:@"OTAOtherViewController" bundle:nil];
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:otherViewController];
			
			// enable swiping on the top view, including navigation bar
			[navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];

			self.slidingViewController.topViewController = navigationController;
			break;
		}
		default:
			break;
	}

	[self.slidingViewController resetTopViewAnimated:YES];
}


@end
