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
-(void)resetBarsAnimate:(BOOL)animate;

@end
