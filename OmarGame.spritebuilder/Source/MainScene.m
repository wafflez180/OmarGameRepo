#import "MainScene.h"
#import "SideBarGoal.h"
#import "MultiplierCircle.h"
#import "ProgressBarController.h"
#import "ProgressTapBar.h"

@implementation MainScene{
    CCLabelTTF *scoreCounter;
    ProgressTapBar *leftBar;
    ProgressTapBar *rightBar;
    ProgressTapBar *bottomBar;
    ProgressTapBar *topLeftBar;
    ProgressTapBar *topRightBar;
    SideBarGoal *leftSideBar;
    SideBarGoal *rightSideBar;
    MultiplierCircle *multiplierCircle;
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
    [self setUpGameAnimate:false];
}

-(void)setUpGameAnimate:(BOOL)animate{
    [self.prgBarsCont resetBarsAnimate:animate];
    [leftSideBar resetAnimate:animate];
    [rightSideBar resetAnimate:animate];
    [multiplierCircle resetAnimate:animate];
    scoreCounter.string = @"0";
    playingGame = false;
}

-(void)startGame{
    [self.prgBarsCont activateBarsWithDifficulty:1];
    playingGame = true;
}

-(void)loseGame{
    NSLog(@"Lost Game");
    [self setUpGameAnimate:true];
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLoc = [touch locationInNode:self];
    CGPoint barLoc = [self.prgBarsCont getBarLoc];
    currentColor = @"yellow";
    
    if(!playingGame){
        [self setUpGameAnimate:true];
        [self startGame];
    }else if(playingGame){
        if(CGRectContainsPoint(leftSideBar.boundingBox,barLoc) && [leftSideBar touchedInGoal:barLoc color:currentColor]){
            NSLog(@"Touched Goal");
            [self activateColors:currentColor completion:^(BOOL finished){
                if (finished) {
                    [self.prgBarsCont resetBarsAnimate:false];
                    [self.prgBarsCont activateBarsWithDifficulty:1];
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
    [leftSideBar activateColor:color];
    [rightSideBar activateColor:color];
    completion(true);
}
/*
- (void)activateColors:(NSString *)color withCompBlock:(void ^)completionBlock{
    [leftSideBar activateColor:color];
    [rightSideBar activateColor:color];
}*/
@end
