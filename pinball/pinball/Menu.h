//
//  Menu.h
//  pinball
//
//  Created by Kristie Syda on 8/24/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Parse/Parse.h>

@interface Menu : SKScene
{
    SKSpriteNode *play;
    SKSpriteNode *leader;
    SKSpriteNode *achieve;
    SKSpriteNode *levels;
    PFUser *currentUser;
}
@end
