//
//  MultiplierCircle.m
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "MultiplierCircle.h"
#import "MainScene.h"

@implementation MultiplierCircle{
    
}

-(void)didLoadFromCCB{
    
}

-(void)resetCircleWithAnimation:(BOOL)animate{
    self.multiplier = 1;
    self.multiLabel.string = @"1x";
}


@end
