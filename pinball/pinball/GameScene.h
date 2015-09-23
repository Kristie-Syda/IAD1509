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
    SKSpriteNode *gateImg;
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
    SKAction *keepFlashing;
    SKAction *keyDrop;
    SKAction *gateDrop;
    SKAction *openGate;
    CGFloat plungerPressed;
    CGFloat plungerReleased;
    SKLabelNode *score;
    SKLabelNode *ballLabel;
    SKPhysicsBody *importantContact;
    int lvl;
    BOOL gameOver;
    BOOL nextLevel;
    BOOL ballTouch;
    BOOL gateClose;
    BOOL ach2;
    BOOL ach3;
    BOOL ach4;
    BOOL ach5;
}

-(id)initWithSize:(CGSize)size level:(NSString*)lvlNum;
@end
