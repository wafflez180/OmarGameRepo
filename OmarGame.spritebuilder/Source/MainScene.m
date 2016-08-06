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
    ProgressBarController *prgBarsCont;
    SideBarGoal *leftSideBar;
    SideBarGoal *rightSideBar;
    MultiplierCircle *multiplierCircle;
    CCNodeColor *bgNodeColor;
    CCSprite *topGoalBar;
    CCSprite *topGoalBarLFill;
    CCSprite *topGoalBarRFill;
}

-(void)didLoadFromCCB{
    NSLog(@"Loaded MainScene");
    self.userInteractionEnabled = true;
    NSArray *prgBars = [[NSArray alloc] initWithObjects:leftBar,rightBar,bottomBar,topLeftBar,topRightBar, nil];
    prgBarsCont = [[ProgressBarController alloc] initWithBars:prgBars];
    [self setUpGame];
}

-(void)setUpGame{
    [prgBarsCont resetBarsAnimate:false];
    [leftSideBar resetAnimate:false];
    [rightSideBar resetAnimate:false];
    [multiplierCircle resetAnimate:false];
    scoreCounter.string = @"0";
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
}

-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    
}

@end
