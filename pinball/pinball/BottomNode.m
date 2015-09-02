//
//  BottomNode.m
//  pinball
//
//  Created by Kristie Syda on 8/25/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "BottomNode.h"
#import "Score.h"

@implementation BottomNode

- (id) init
{
    if (self = [super init]) {
        
        //sound effect
        SFX = [SKAction playSoundFileNamed:@"lose.caf" waitForCompletion:NO];
    }
    
    return self;
}


- (BOOL) collision:(SKNode *)ball {
    
    //Adds current score to total
    [[Score shared] add:[Score shared].currentScore];
    
    //resets current score
    [Score shared].currentScore = 0;
    
    //lose one ball
    [Score shared].ball -= 1;
    
    //sound effect
    [self runAction:SFX];
    
    return YES;
}

@end
