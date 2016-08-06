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

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if(!playingGame){
        [self setUpGameAnimate:true];
        [self startGame];
    }else if(playingGame){
        [self.prgBarsCont activateBarsWithDifficulty:1];
    }
}

-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
}

@end
