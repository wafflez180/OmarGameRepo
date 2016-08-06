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
}

-(id)initWithBars:(NSArray *)bars{
    prgBars = [[NSArray alloc] initWithArray:bars];
    leftBar = [prgBars objectAtIndex:0];
    rightBar = [prgBars objectAtIndex:1];
    bottomBar = [prgBars objectAtIndex:2];
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
}

@end
