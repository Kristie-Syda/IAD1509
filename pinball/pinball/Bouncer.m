//
//  Bouncer.m
//  pinball
//
//  Created by Kristie Syda on 8/25/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Bouncer.h"
#import "Score.h"


@implementation Bouncer

- (id) init
{
    if (self = [super init]) {
        
        //sound effect
        SFX = [SKAction playSoundFileNamed:@"bouncer.caf" waitForCompletion:NO];
        
        //light up animation
        SKAction *light = [SKAction sequence:@[[SKAction colorizeWithColor:[SKColor greenColor] colorBlendFactor:2.0 duration:0.15],[SKAction colorizeWithColorBlendFactor:0.0 duration:0.1]]];
        lightUp = [SKAction runAction:light onChildWithName:@"child_bouncer"];
    }
    return self;
}

- (BOOL) collision:(SKNode *)ball {
    
    //light up animation
    [self runAction:lightUp];

    //update score
    [Score shared].currentScore += 10;
    
    //sound effect
    [self.parent runAction:SFX];
    
    return YES;
}


@end
