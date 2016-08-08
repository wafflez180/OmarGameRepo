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
    bool isRightGoal;
    bool isLeftGoal;
}

-(void)didLoadFromCCB{
    goalArray = [[NSArray alloc] initWithObjects:greenGoal,blueGoal,redGoal,yellowGoal, nil];
    if(self.position.x == 1){//If it is the right sideGoal
        isRightGoal = true;
    }else{
        isLeftGoal = true;
    }
    [self resetAnimate:false];
}

-(void)resetAnimate:(BOOL)animate{
    float startingYOrigin = 0.0;//Debugging purposed change y to 0.75
    if(isRightGoal){
        [self setPosition:CGPointMake(1.0, startingYOrigin)];
        [self setAnchorPoint:CGPointMake(1.0, 0.0)];
    }else{
        [self setPosition:CGPointMake(0.0, startingYOrigin)];
        [self setAnchorPoint:CGPointMake(0.0, 0.0)];
    }
    self.rotation = 0;
    for(CCNodeColor *goal in goalArray){
        goal.opacity = 0.5;
        if(goal.children.count>0){
            for(CCNode *child in goal.children){
                child.opacity=0.5;
            }
        }
    }
}

-(void)resetColors{
    for(CCNodeColor *goal in goalArray){
        goal.opacity = 0.5;
        if(goal.children.count>0){
            for(CCNode *child in goal.children){
                child.opacity=0.5;
            }
        }
    }
}

-(void)activateAllColors{
    for(CCNodeColor *goal in goalArray){
        goal.opacity = 1.0;
        if(goal.children.count>0){
            for(CCNode *child in goal.children){
                child.opacity=1.0;
            }
        }
    }
}
  
  - (void)activateColor:(NSString *)color{
      for(CCNodeColor *goal in goalArray){
        if([goal.name isEqualToString:color]){
            goal.opacity = 1.0;
            if(goal.children.count>0){
                for(CCNode *child in goal.children){
                    child.opacity=1.0;
                }
            }
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
    }else if(goalsLeftToActivate.count == 0 && redGoal.name && self.position.y < 1.0){
        return @"allSelected";
    }else if(self.position.y == 1.0){
        return @"advanceToNextLevel";
    }
    return @"yellow";
}

-(BOOL)touchedInGoal:(CGPoint)touch color:(NSString *)color{
    //Get the goal with the same color and check if it is in the boundingbox
    for(CCNodeColor *goal in goalArray){
        if([goal.name isEqualToString:color]){
            float padding = 5.0;
            //Add padding to the box to make it easier and adjust origin to make it relative to the screen
            CGRect goalBoundingBox = goal.boundingBox;
            goalBoundingBox.origin.x+=self.positionInPoints.x;
            goalBoundingBox.origin.y+=(self.positionInPoints.y-self.contentSize.height);//Get the bottom of the entire sideGoal and add it to the y of goal
            goalBoundingBox.size.height+=padding;
            goalBoundingBox.size.width+=padding;
            NSLog(@"TOUCH X: %f Y: %f", touch.x, touch.y);
            NSLog(@"X: %f Y: %f \n W: %f H: %f",goalBoundingBox.origin.x,goalBoundingBox.origin.y,goalBoundingBox.size.width,goalBoundingBox.size.height);
            
            if(CGRectContainsPoint(goalBoundingBox, touch) && [goal.name isEqualToString:color]){
                return true;
            }
        }
    }
    return false;
}

-(void)advanceGoalWithAnimationDuration:(float)duration{
    if(self.position.y == 0.75){//Execute when the sideGoal will exit the screen
        [self copySideBarAndAnimateWithDuration:duration];
    }else{
        CCActionMoveTo *moveUp = [[CCActionMoveTo alloc] initWithDuration:duration position:CGPointMake(self.position.x, self.position.y+0.25)];
        [self runAction:moveUp];
        [self performSelector:@selector(resetColors) withObject:nil afterDelay:duration];
    }
}

-(void)copySideBarAndAnimateWithDuration:(float)duration{
    if(self.position.x < 0.5){//If it is the left sideGoal
        [self replicateAndAnimateUpWithDuration:duration];
        //Prepare real sideGoal and animate it in sideways
        self.rotation = 90;
        [self setPosition:CGPointMake(self.position.x, 1.0)];
        self.anchorPoint = CGPointMake(self.anchorPoint.x, 1.0);
        CCActionMoveTo *moveRight = [[CCActionMoveTo alloc] initWithDuration:duration position:CGPointMake(self.contentSizeInPoints.height/self.parent.contentSizeInPoints.width, self.position.y)];
        [self runAction:moveRight];
        //[self performSelector:@selector(resetColors) withObject:nil afterDelay:duration];
    }else{
        [self replicateAndAnimateUpWithDuration:duration];
        //Prepare real sideGoal and animate it in sideways
        self.rotation = -90;
        [self setPosition:CGPointMake(self.position.x, 1.0)];
        self.anchorPoint = CGPointMake(1.0, 1.0);
        CCActionMoveTo *moveLeft = [[CCActionMoveTo alloc] initWithDuration:duration position:CGPointMake(1.0-(self.contentSizeInPoints.height/self.parent.contentSizeInPoints.width), self.position.y)];
        [self runAction:moveLeft];
        //[self performSelector:@selector(resetColors) withObject:nil afterDelay:duration];
    }
}

-(void)replicateAndAnimateUpWithDuration:(float)duration{
    CCActionMoveTo *moveUp = [[CCActionMoveTo alloc] initWithDuration:duration position:CGPointMake(self.positionInPoints.x, self.positionInPoints.y+self.contentSizeInPoints.height+18)];
    SideBarGoal *replicatedSideGoal = (SideBarGoal*)[CCBReader load:@"sideBarGoal"];
    [self.parent addChild:replicatedSideGoal];
    [replicatedSideGoal setAnchorPoint:self.anchorPoint];
    [replicatedSideGoal setPositionInPoints:self.positionInPoints];
    [replicatedSideGoal setContentSize:self.contentSize];
    [replicatedSideGoal activateAllColors];
    [replicatedSideGoal runAction:moveUp];
    [replicatedSideGoal performSelector:@selector(removeFromParentAndCleanup:) withObject:[NSNumber numberWithBool:true] afterDelay:duration];
}


@end
