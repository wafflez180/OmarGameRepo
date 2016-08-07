//
//  ProgressTapBar.m
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "ProgressTapBar.h"
#import "ProgressBarController.h"
#import "MainScene.h"

@implementation ProgressTapBar{
    BOOL isHorizontalBar;
    BOOL isVerticalBar;
    int barStage;
}

-(void)didLoadFromCCB{

}

-(void)reset{
    [self stopAllActions];
    [self.animationTimer invalidate];
    self.animationTimer = nil;
    self.isAnimating = false;
    if([self.name isEqualToString:@"topGoal"]){
        [self setPosition:CGPointMake(0.0, self.position.y)];
        barStage=3;
    }else if([self.name isEqualToString:@"sideGoal"]){
        [self setPosition:CGPointMake(self.position.x, 0.0)];
        barStage=2;
    }else if([self.name isEqualToString:@"bottomGoal"]){
        self.scaleX = 0.1;
        barStage=1;
    }
    self.opacity = 0;
    for(CCSprite *roundedEdge in self.children){
        roundedEdge.opacity = 0;
    }
}

-(void)setup{
    self.opacity = 1;
    for(CCSprite *roundedEdge in self.children){
        roundedEdge.opacity = 1;
    }
    if([self.name isEqualToString:@"topGoal"]){
        [self setPosition:CGPointMake(0.0, self.position.y)];
    }else if([self.name isEqualToString:@"sideGoal"]){
        [self setPosition:CGPointMake(self.position.x, 0.0)];
    }else if([self.name isEqualToString:@"bottomGoal"]){
        self.scaleX = 0.1;
    }
}

-(void)startAnimatingWithDuration:(float)duration timer:(BOOL)timer{
    if(!self.animationTimer && !_isAnimating){
        self.isAnimating = true;
        [self setup];
        //If it is the top bar
        if(timer && ([self.name isEqualToString:@"topGoal"] || [self.name isEqualToString:@"bottomGoal"])){
            self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:duration/2
                                                                   target:self
                                                                 selector:@selector(stopAnimating)
                                                                 userInfo:nil
                                                                  repeats:NO];
        }else if(timer){
            self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                                   target:self
                                                                 selector:@selector(stopAnimating)
                                                                 userInfo:nil
                                                                  repeats:NO];
        }
        /*
         [UIView beginAnimations:nil context:NULL];
         [UIView setAnimationDuration:duration];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
         [UIView setAnimationBeginsFromCurrentState:YES];*/
        
        if([self.name isEqualToString:@"topGoal"]){
            CCActionMoveTo *moveAction = [[CCActionMoveTo alloc] initWithDuration:duration/2 position:CGPointMake(1.0, self.position.y)];
            [self runAction:moveAction];
        }else if([self.name isEqualToString:@"sideGoal"]){
            CCActionMoveTo *moveAction = [[CCActionMoveTo alloc] initWithDuration:duration position:CGPointMake(self.position.x, 1.0)];
            [self runAction:moveAction];
        }else if([self.name isEqualToString:@"bottomGoal"]){
            CCActionScaleTo *scaleAction = [[CCActionScaleTo alloc] initWithDuration:duration/2 scale:1.0];
            [self runAction:scaleAction];
            
            for (CCSprite *child in self.children) {
                //[child runAction: wdaw];
                child.opacity = 0;
            }
        }
    }
    //[UIView commitAnimations];
}

-(void)stopAnimating{
    if(self.isAnimating){
        self.isAnimating = false;
        MainScene *mainScene = (MainScene *)self.parent;
        [mainScene.prgBarsCont animateNextBarAtStage:barStage+1];
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
}


@end
