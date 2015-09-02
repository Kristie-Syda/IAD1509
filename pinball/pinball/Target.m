//
//  Target.m
//  pinball
//
//  Created by Kristie Syda on 8/25/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Target.h"
#import "Score.h"

@implementation Target
- (id) init
{
    if (self = [super init]) {
        
        //sound effect
        SFX = [SKAction playSoundFileNamed:@"target.caf" waitForCompletion:NO];
        
        //Target SKActions
        SKAction *movingRight = [SKAction moveToX:337 - 100 duration:3];
        SKAction *movingLeft = [SKAction moveToX:70 duration:4];
        NSArray *movesArray = @[movingRight,movingLeft];
        SKAction *leftToRight = [SKAction sequence:movesArray];
        movingTarget = [SKAction repeatActionForever:leftToRight];
        
        //makes target move
        [self runAction:movingTarget];    
    }
    
    return self;
}


- (BOOL) collision:(SKNode *)ball {
    
    //update score
    [Score shared].currentScore += 100;
    
    //sound effect
    [self.parent runAction:SFX];
    
    //remove target
    [self removeFromParent];
    
    return YES;
}

@end
