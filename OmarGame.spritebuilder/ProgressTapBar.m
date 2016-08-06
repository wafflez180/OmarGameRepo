//
//  ProgressTapBar.m
//  OmarGame
//
//  Created by Arthur De Araujo on 8/6/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "ProgressTapBar.h"

@implementation ProgressTapBar{
    
}

-(void)didLoadFromCCB{

}

-(void)reset{
    //If it is a horizontal bar
    if(self.position.x < 1){
        //NSLog(@"Horizontal Bar");
        [self setContentSize:CGSizeMake(0.0, self.contentSize.height)];
        
    //If it is a vertical bar
    }else{
        //NSLog(@"Vertical Bar");
        [self setContentSize:CGSizeMake(self.contentSize.width, 0.0)];
    }
    self.opacity = 0;
    for(CCSprite *roundedEdge in self.children){
        roundedEdge.opacity = 0;
    }
}

@end
