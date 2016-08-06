//
//  ProgressTapBar.h
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNodeColor.h"

@interface ProgressTapBar : CCNodeColor

@property BOOL isAnimating;

-(void)reset;

-(void)startAnimatingWithDuration:(float)duration timer:(BOOL)timer;
@end
