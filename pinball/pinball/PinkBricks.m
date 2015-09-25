//
//  PinkBricks.m
//  pinball
//
//  Created by Kristie Syda on 8/25/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//


#import "PinkBricks.h"
#import "Score.h"


@implementation PinkBricks



- (id) init
{
    if (self = [super init]) {
        
        brick = [SKAction playSoundFileNamed:@"brick.caf" waitForCompletion:NO];
    }
    
    return self;
}


- (BOOL) collision:(SKNode *)ball {
    
    //sound effect
    [self.parent runAction:brick];
    
    //brick animation
    [self removeFromParent];

    //update score
    [Score shared].currentScore += 50;
  
    //update pink brick count
    [Score shared].pinkCount -= 1;
    [Score shared].brickHit += 1;
  
    return YES;
}

@end
