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
        
//        //Explosion animation
//        SKTextureAtlas *expAtlas = [SKTextureAtlas atlasNamed:@"explosion"];
//        NSArray *expNames = [expAtlas textureNames];
//        NSArray *sorted = [expNames sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
//        
//        NSMutableArray *expArray = [NSMutableArray array];
//        
//        for (NSString *name in sorted) {
//            SKTexture *explodetexture = [expAtlas textureNamed:name];
//            
//            [expArray addObject:explodetexture];
//        }
//        
//        //explosion SKAction -- shows animation then makes node disappear
//        SKAction *explosionChild = [SKAction runAction:[SKAction animateWithTextures:expArray timePerFrame:0.05] onChildWithName:@"child_pink"];
//        
//        //explodes the child node then makes the whole node disappear
//        explosion = [SKAction sequence:@[explosionChild,[SKAction removeFromParent]]];
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
  
    return YES;
}

@end
