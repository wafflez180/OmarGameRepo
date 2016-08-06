//
//  MultiplierCircle.m
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "MultiplierCircle.h"
#import "MainScene.h"

@implementation MultiplierCircle{
    
}

-(void)didLoadFromCCB{
    
}

-(void)resetAnimate:(BOOL)animate{
    if(animate){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
    }
    
    self.multiplier = 1;
    self.multiLabel.string = @"1x";
    
    if(animate){
        [UIView commitAnimations];
    }
    
}

@end
