//
//  SideBarGoal.h
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface SideBarGoal : CCNode

-(void)resetAnimate:(BOOL)animate;
-(BOOL)touchedInGoal:(CGPoint)touch color:(NSString *)color;
- (void)activateColor:(NSString *)color;
-(NSString *)selectRandomColor;
-(void)advanceGoalWithAnimationDuration:(float)duration;

@end
