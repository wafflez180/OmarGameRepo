//
//  MultiplierCircle.h
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface MultiplierCircle : CCSprite

@property (strong, nonatomic) CCLabelTTF *multiLabel;
@property (nonatomic) int multiplier;

-(void)resetAnimate:(BOOL)animate;

@end
