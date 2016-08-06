//
//  SideBarGoal.m
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "SideBarGoal.h"

@implementation SideBarGoal{
    CCNodeColor *greenGoal;
    CCNodeColor *blueGoal;
    CCNodeColor *redGoal;
    CCNodeColor *yellowGoal;
    NSArray *goalArray;
}

-(void)didLoadFromCCB{
    //If it is the right sideGoal
    if(self.position.x == 1){
        [self setAnchorPoint:CGPointMake(1.0, 0.5)];
    }
    goalArray = [[NSArray alloc] initWithObjects:greenGoal,blueGoal,redGoal,yellowGoal, nil];
}

-(void)resetAnimate:(BOOL)animate{
    if(animate){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
    }
    
    [self setPosition:CGPointMake(self.position.x, self.contentSize.height/2)];
    for(CCNodeColor *goal in goalArray){
        goal.opacity = 0.5;
        
        if(goal.children.count>0){
            for(CCNode *child in goal.children){
                child.opacity=0.5;
            }
        }
    }
    
    if(animate){
        [UIView commitAnimations];
    }

}

@end
