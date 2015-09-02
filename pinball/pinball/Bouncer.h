//
//  Bouncer.h
//  pinball
//
//  Created by Kristie Syda on 8/25/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "TableMaker.h"
#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(int, Type) {
    Bouncer_1,
    Bouncer_2,
    Bouncer_3,
};

@interface Bouncer : TableMaker
{
    SKAction *SFX;
    SKAction *lightUp;
}


@property(nonatomic,assign)Type type;
- (BOOL) collision:(SKNode *)ball;

@end
