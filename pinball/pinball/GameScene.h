//
//  GameScene.h
//  pinball
//

//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>


-(id)initWithSize:(CGSize)size level:(NSString*)lvlNum;
@end
