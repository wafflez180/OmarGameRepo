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
    [self setPosition:CGPointMake(self.position.x, self.contentSize.height/2)];
    for(CCNodeColor *goal in goalArray){
        goal.opacity = 0.5;
        
        if(goal.children.count>0){
            for(CCNode *child in goal.children){
                child.opacity=0.5;
            }
        }
    }
}

- (void)activateColor:(NSString *)color{
    for(CCNodeColor *goal in goalArray){
        if([goal.name isEqualToString:color]){
            goal.opacity = 1;
        }
    }
}

-(NSMutableArray*)getDeActivatedGoals{
    NSMutableArray *goalsLeftToActivate = [[NSMutableArray alloc] init];
    for(CCNodeColor *goal in goalArray){
        if(goal.opacity < 1.0){
            [goalsLeftToActivate addObject:goal];
        }
    }
    return goalsLeftToActivate;
}

-(NSString *)selectRandomColor{
    NSMutableArray *goalsLeftToActivate = [self getDeActivatedGoals];
    if(goalsLeftToActivate.count > 1){
        int randIndex = rand() % ((goalsLeftToActivate.count) - 0) + 0; //create the random number.
        CCNodeColor *goal = goalsLeftToActivate[randIndex];
//        NSLog(@"Random Color: %@, COUNT: %lu",goal.name,(unsigned long)goalsLeftToActivate.count);
        return goal.name;
    }else if(goalsLeftToActivate.count == 1){
        CCNodeColor *goal = goalsLeftToActivate[0];
        return goal.name;
    }
    return @"yellow";
}

-(BOOL)touchedInGoal:(CGPoint)touch color:(NSString *)color{
    for(CCNodeColor *goal in goalArray){
        if(CGRectContainsPoint(goal.boundingBox, touch) && [goal.name isEqualToString:color]){
            return true;
        }
    }
    return false;
}

@end
