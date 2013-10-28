//
//  MainViewController.m
//  TB_CustomTransitionIOS7
//
//  Created by Yari Dareglia on 9/29/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import "MainViewController.h"
#import "ModalViewController.h"
#import "TransitionManager.h"

@import MapKit;

@interface MainViewController ()
@property (nonatomic, weak) IBOutlet MKMapView *map;
@property (nonatomic, strong) TransitionManager *transitionManager;
@end

@implementation MainViewController





#pragma mark - Initialization / Config 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)setup{
    
    //TransitionManager class implements the UIViewControllerAnimatedTransitioning protocol
    //Its instance is responsible to mange transitions in this controller.
    self.transitionManager = [[TransitionManager alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    
    //Simple gesture recognizer for Swipe
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(presentInfo:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipe];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





#pragma mark - UI interactions - 

-(void)presentInfo:(UIGestureRecognizer*)gesture{
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    ModalViewController *modal = [[ModalViewController alloc]init];
    modal.transitioningDelegate = self;
    [self presentViewController:modal animated:YES completion:^{
    }];
}





#pragma mark - UIVieControllerTransitioningDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source{
    self.transitionManager.transitionTo = MODAL;
    return self.transitionManager;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transitionManager.transitionTo = INITIAL;
    return self.transitionManager;
}

@end