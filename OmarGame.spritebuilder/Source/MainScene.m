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
    [self resetBars];
    [leftSideBar resetAnimate:animate];
    [rightSideBar resetAnimate:animate];
    [multiplierCircle resetAnimate:animate];
    scoreCounter.string = @"0";
    playingGame = false;
}

-(void)startGame{
    [self resetBars];
    playingGame = true;
}

-(void)loseGame{
    NSLog(@"Lost Game");
    [self setUpGameAnimate:true];
}

-(void)resetBars{
    currentColor = [leftSideBar selectRandomColor];
    [self.prgBarsCont activateBarsWithDifficulty:1 withColor: currentColor];
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    CGPoint touchLoc = [touch locationInNode:self];
    CGPoint barLoc = [self.prgBarsCont getBarLoc];
    
    if(!playingGame){
        [self setUpGameAnimate:true];
        [self startGame];
    }else if(playingGame){
        //NSLog(@"BARLOC: X: %f Y: %f",barLoc.x, barLoc.y);
        if(CGRectContainsPoint(leftSideBar.boundingBox,barLoc) && [leftSideBar touchedInGoal:barLoc color:currentColor]){
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
    [leftSideBar activateColor:color];
    [rightSideBar activateColor:color];
    completion(true);
}
@end
