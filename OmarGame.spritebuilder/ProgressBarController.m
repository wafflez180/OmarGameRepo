//
//  ProgressBarController.m
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "ProgressBarController.h"
#import "ProgressTapBar.h"

@implementation ProgressBarController{
    ProgressTapBar *leftBar;
    ProgressTapBar *rightBar;
    ProgressTapBar *bottomBar;
    ProgressTapBar *topLeftBar;
    ProgressTapBar *topRightBar;
    NSArray *prgBars;
    float animationDuration;
    float animating;
    int animatingBarStage;
}

-(id)initWithBars:(NSArray *)bars{
    prgBars = [[NSArray alloc] initWithArray:bars];
    bottomBar = [prgBars objectAtIndex:0];
    leftBar = [prgBars objectAtIndex:1];
    rightBar = [prgBars objectAtIndex:2];
    topLeftBar = [prgBars objectAtIndex:3];
    topRightBar = [prgBars objectAtIndex:4];
    [self resetBarsAnimate:false];
    
    return self;
}

-(void)resetBarsAnimate:(BOOL)animate{
    if(animate){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
    }
    for(ProgressTapBar *prgBar in prgBars){
        [prgBar reset];
    }
    if(animate){
        [UIView commitAnimations];
    }
    animatingBarStage = 0;
}

-(void)activateBarsWithDifficulty:(float)difficulty{
    if(!animating){
        [self resetBarsAnimate:true];
        animating = true;
        animationDuration = 1.0;
        animatingBarStage = 1;
        [bottomBar startAnimatingWithDuration:animationDuration timer:true];
    }
}

-(void)animateNextBar{
    animatingBarStage++;
    NSLog(@"Bar Stage: %d", animatingBarStage);
    if(animatingBarStage == 2){
        [leftBar startAnimatingWithDuration:animationDuration timer:false];
        [rightBar startAnimatingWithDuration:animationDuration timer:true];
    }else if(animatingBarStage == 3){
        [topLeftBar startAnimatingWithDuration:animationDuration timer:false];
        [topRightBar startAnimatingWithDuration:animationDuration timer:true];
    }else{
        animating = false;
    }
}

@end
