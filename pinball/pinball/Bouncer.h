//
//  Bouncer.h
//  pinball
//
//  Created by Kristie Syda on 8/25/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "TableMaker.h"
#import <SpriteKit/SpriteKit.h>

@interface Bouncer : TableMaker
{
    SKAction *SFX;
    SKAction *lightUp;
}


- (BOOL) collision:(SKNode *)ball;

@end
