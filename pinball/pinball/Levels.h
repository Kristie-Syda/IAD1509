//
//  Levels.h
//  pinball
//
//  Created by Kristie Syda on 9/3/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Levels : SKScene

{
    NSInteger level;
    BOOL unlocked;
    SKSpriteNode *star1;
    SKSpriteNode *star2;
    SKSpriteNode *star3;
    SKSpriteNode *star4;
    SKSpriteNode *star5;
    SKSpriteNode *star6;
}
@end
