#import "MainScene.h"
#import "SideBarGoal.h"
#import "MultiplierCircle.h"
#import "TopMultiplierBar.h"
#import "ProgressBarController.h"
#import "ProgressTapBar.h"

@implementation MainScene{
    CCLabelTTF *scoreCounter;
    ProgressTapBar *leftBar;
    ProgressTapBar *rightBar;
    ProgressTapBar *bottomBar;
    ProgressTapBar *topLeftBar;
    ProgressTapBar *topRightBar;
    SideBarGoal *leftSideGoal;
    SideBarGoal *rightSideGoal;
    MultiplierCircle *multiplierCircle;
    TopMultiplierBar *topMultiplierBar;
    CCNodeColor *bgNodeColor;
    CCSprite *topGoalBar;
    CCSprite *topGoalBarLFill;
    CCSprite *topGoalBarRFill;
    NSString *currentColor;
    BOOL playingGame;
}

-(void)didLoadFromCCB{
    NSLog(@"Loaded MainScene");
    self.userInteractionEnabled = true;
    NSArray *prgBars = [[NSArray alloc] initWithObjects:bottomBar,leftBar,rightBar,topLeftBar,topRightBar, nil];
    self.prgBarsCont = [[ProgressBarController alloc] initWithBars:prgBars];
    [topMultiplierBar resetBarWithAnimation:false];
    [multiplierCircle resetCircleWithAnimation:false];
    [self setUpGameAnimate:false];
}

-(void)setUpGameAnimate:(BOOL)animate{
    [leftSideGoal resetAnimate:animate];
    [rightSideGoal resetAnimate:animate];
    [multiplierCircle resetCircleWithAnimation:animate];
    scoreCounter.string = @"0";
    playingGame = false;
}

-(void)startGame{
    [self resetBars];
    playingGame = true;
}

-(void)loseGame{
    NSLog(@"Lost Game");
    [self.prgBarsCont resetBarsAnimate:false color:nil];
    [self setUpGameAnimate:true];
}

-(void)resetBars{
    currentColor = [leftSideGoal selectRandomColor];
    if([currentColor isEqualToString:@"allSelected"]){
        float animationDuration = 2.0;
        [leftSideGoal advanceGoalWithAnimationDuration:animationDuration];
        [rightSideGoal advanceGoalWithAnimationDuration:animationDuration];
        [self.prgBarsCont resetBarsAnimate:false color:@"yellow"];
        [self performSelector:@selector(resetBars) withObject:nil afterDelay:animationDuration];
    }else if([currentColor isEqualToString:@"advanceToNextLevel"]){
        
    }else{
        [self.prgBarsCont activateBarsWithDifficulty:1 withColor: currentColor];
    }
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLoc = [touch locationInNode:self];
    CGPoint barLoc = [self.prgBarsCont getBarLoc];
    
    if(!playingGame){
        [self setUpGameAnimate:true];
        [self startGame];
    }else if(playingGame){
        //If the user pressed inside the goal, activate the color. ELSE: lose the game
        if([leftSideGoal touchedInGoal:barLoc color:currentColor]){
            NSLog(@"Touched Goal");
            [self activateColors:currentColor completion:^(BOOL finished){
                if (finished) {
                    [self resetBars];
                }
            }];
        }else{
            [self loseGame];
        }
    }
}


-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
}
- (void)activateColors:(NSString *)color completion:(void (^)(BOOL finished))completion{
    [leftSideGoal activateColor:color];
    [rightSideGoal activateColor:color];
    completion(true);
}
@end
