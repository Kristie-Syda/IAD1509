//
//  GameOver.h
//  pinball
//
//  Created by Kristie Syda on 8/18/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface GameOver : SKScene <FBSDKSharingDelegate>
{
    SKLabelNode *lbl;
    SKNode *touched;
    NSNumber *level;
    NSNumber *totalScore;
    NSString *playerId;
    FBSDKShareLinkContent *content;
    NSNumber *previousScore;
    NSNumber *previousLevel;
    FBSDKShareButton *shareButton;
}


@end
