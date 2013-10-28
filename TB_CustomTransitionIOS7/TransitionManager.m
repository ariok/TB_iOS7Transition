//
//  TransitionManager.m
//  TB_CustomTransitionIOS7
//
//  Created by Yari Dareglia on 10/22/13.
//  Copyright (c) 2013 Bitwaker. All rights reserved.
//

#import "TransitionManager.h"

@implementation TransitionManager


#pragma mark - UIViewControllerAnimatedTransitioning -

//Define the transition duration
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}


//Define the transition
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //STEP 1
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
    
    /*STEP 2:   Draw different transitions depending on the view to show
                for sake of clarity this code is divided in two different blocks
     */
    
    //STEP 2A: From the First View(INITIAL) -> to the Second View(MODAL)
    if(self.transitionTo == MODAL){
        
        //1.Settings for the fromVC ............................
        CGAffineTransform rotation;
        rotation = CGAffineTransformMakeRotation(M_PI);
        fromVC.view.frame = sourceRect;
        fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.0);
        fromVC.view.layer.position = CGPointMake(160.0, 0);
        
        //2.Insert the toVC view...........................
        UIView *container = [transitionContext containerView];
        [container insertSubview:toVC.view belowSubview:fromVC.view];
        CGPoint final_toVC_Center = toVC.view.center;
        
        toVC.view.center = CGPointMake(-sourceRect.size.width, sourceRect.size.height);
        toVC.view.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        //3.Perform the animation...............................
        [UIView animateWithDuration:1.0
                              delay:0.0
             usingSpringWithDamping:.8
              initialSpringVelocity:6.0
                            options:UIViewAnimationOptionCurveEaseIn
         
                         animations:^{
                             
                             //Setup the final parameters of the 2 views
                             //the animation interpolates from the current parameters
                             //to the next values.
                             fromVC.view.transform = rotation;
                             toVC.view.center = final_toVC_Center;
                             toVC.view.transform = CGAffineTransformMakeRotation(0);
                         } completion:^(BOOL finished) {
                             
                             //When the animation is completed call completeTransition
                             [transitionContext completeTransition:YES];
                             
                         }];
    }
    
    //STEP 2B: From the Second view(MODAL) -> to the First View(INITIAL)
    else{
        
        //Settings for the fromVC ............................
        CGAffineTransform rotation;
        rotation = CGAffineTransformMakeRotation(M_PI);
        UIView *container = [transitionContext containerView];
        fromVC.view.frame = sourceRect;
        fromVC.view.layer.anchorPoint = CGPointMake(0.5, 0.0);
        fromVC.view.layer.position = CGPointMake(160.0, 0);
        
        //Insert the toVC view view...........................
        [container insertSubview:toVC.view belowSubview:fromVC.view];

        toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.0);
        toVC.view.layer.position = CGPointMake(160.0, 0);
        toVC.view.transform = CGAffineTransformMakeRotation(-M_PI);
        
        //Perform the animation...............................
        [UIView animateWithDuration:1.0
                              delay:0.0
             usingSpringWithDamping:0.8
              initialSpringVelocity:6.0
                            options:UIViewAnimationOptionCurveEaseIn
         
                         animations:^{
                             
                             //Setup the final parameters of the 2 views
                             //the animation interpolates from the current parameters
                             //to the next values.
                             fromVC.view.center = CGPointMake(fromVC.view.center.x - 320, fromVC.view.center.y);
                             toVC.view.transform = CGAffineTransformMakeRotation(-0);
                             
                         } completion:^(BOOL finished) {
                             
                             //When the animation is completed call completeTransition
                             [transitionContext completeTransition:YES];
                             
                         }];
    }

    
}

@end
