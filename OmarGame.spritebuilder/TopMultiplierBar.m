//
//  TopMultiplierBar.m
//  OmarGame
//
//  Created by Arthur De Araujo on 8/7/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TopMultiplierBar.h"

@implementation TopMultiplierBar{
    
}

-(void)didLoadFromCCB{
    CCSprite *topBarEndPiece = [self.children objectAtIndex:0];
    float sideBarHeight = topBarEndPiece.contentSizeInPoints.width + (([UIScreen mainScreen].bounds.size.height*0.25)/2);
    float sideBarWidth = 18.0;
    [self setContentSize:CGSizeMake(topBarEndPiece.contentSizeInPoints.width-sideBarHeight, sideBarWidth)];
}

-(void)resetBarWithAnimation:(BOOL)animate{
    if (animate) {
        
    }else{
        float roundedSideBarTopHeight = 9.0;
        float sideBarColoredGoalHeight = ([UIScreen mainScreen].bounds.size.height*0.25)*.25;
        float sideBarHeight = (([UIScreen mainScreen].bounds.size.height*0.25)/2)+(roundedSideBarTopHeight*2);
        float sideBarWidth = 18.0;
        [self setContentSize:CGSizeMake(sideBarHeight + sideBarColoredGoalHeight, sideBarWidth)];
    }
}
@end
