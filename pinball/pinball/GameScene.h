//
//  GameScene.h
//  pinball
//

//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
//Variables
{
    SKSpriteNode *ball;
    SKSpriteNode *plunger;
    SKSpriteNode *leftBump;
    SKSpriteNode *rightBump;
    SKSpriteNode *pauseButton;
    SKSpriteNode *playBtn;
    SKSpriteNode *key;
    SKNode *menuNode;
    SKLabelNode *pauseLbl;
    SKLabelNode *scoreLabel;
    SKNode *touched;
    NSString *plungBall;
    SKAction *springs;
    SKAction *bumpers;
    SKAction *released;
    SKAction *edge;
    SKAction *done;
    SKAction *flippedLeft;
    SKAction *flippedRight;
    SKAction *movingTarget;
    SKAction *keepFlashing;
    SKAction *keyDrop;
    CGFloat plungerPressed;
    CGFloat plungerReleased;
    NSTimeInterval current;
    NSTimeInterval previous;
    SKLabelNode *score;
    SKLabelNode *ballLabel;
    SKPhysicsBody *importantContact;
    int lvl;
    
    BOOL gameOver;
    BOOL nextLevel;
    BOOL ballTouch;
}

-(id)initWithSize:(CGSize)size level:(NSString*)lvlNum;
@end
