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
    [self resetBarsAnimate:false color:@"yellow"];
    
    return self;
}

-(void)resetBarsAnimate:(BOOL)animate color:(NSString *)color{
    for(ProgressTapBar *prgBar in prgBars){
        [prgBar reset];
        [prgBar setBarColor:color];
    }
    //NSLog(@"COLOR: %@",color);
    animatingBarStage = 1;
}

-(void)activateBarsWithDifficulty:(float)difficulty withColor: (NSString*)color{
    [self resetBarsAnimate:false color:color];
    animating = true;
    animationDuration = 3.0;
    if(!bottomBar.isAnimating){
        [bottomBar startAnimatingWithDuration:animationDuration timer:true];
    }
}

-(void)animateNextBarAtStage:(int)stage{
    if(animating){
        animatingBarStage = stage;
        NSLog(@"Bar Stage: %d", animatingBarStage);
        if(stage == 2){
            bottomBar.isAnimating = false;
            [leftBar startAnimatingWithDuration:animationDuration timer:false];
            [rightBar startAnimatingWithDuration:animationDuration timer:true];
        }else if(stage == 3){
            [topLeftBar startAnimatingWithDuration:animationDuration timer:false];
            [topRightBar startAnimatingWithDuration:animationDuration timer:true];
        }else{
            animating = false;
        }
    }
}

-(CGPoint)getBarLoc{
    if(animatingBarStage == 1){
        NSLog(@"X: %f \nY: %f", [UIScreen mainScreen].bounds.size.width/2-([UIScreen mainScreen].bounds.size.width/2 * bottomBar.scaleX), bottomBar.contentSize.height/2);
        return CGPointMake([UIScreen mainScreen].bounds.size.width/2-([UIScreen mainScreen].bounds.size.width/2 * bottomBar.scaleX), bottomBar.contentSize.height/2);
    }else if(animatingBarStage == 2){
        NSLog(@"X: %f \nY: %f", leftBar.contentSize.width/2, leftBar.positionInPoints.y);
        return CGPointMake(5, leftBar.positionInPoints.y);
    }else if(animatingBarStage == 3){
        return CGPointMake(topLeftBar.positionInPoints.x, topLeftBar.positionInPoints.y - (topLeftBar.contentSize.height/2));
    }
    return CGPointMake(-100, -100);
}


@end
