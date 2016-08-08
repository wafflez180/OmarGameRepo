//
//  ProgressBarController.h
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

@interface ProgressBarController : NSObject

-(id)initWithBars:(NSArray *)bars;
-(void)setUpCont;
-(void)activateBarsWithDifficulty:(float)difficulty withColor: (NSString*)color;
-(void)animateNextBarAtStage:(int)stage;
-(CGPoint)getBarLoc;
- (void)activateColor:(NSString *)color
        withCompBlock:(void (^)(BOOL time))completionBlock;
-(void)resetBarsAnimate:(BOOL)animate color:(NSString *)color;
@end
