//
//  GameOver.m
//  pinball
//
//  Created by Kristie Syda on 8/18/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "GameOver.h"
#import "GameScene.h"
#import "Menu.h"
#import "Score.h"

@implementation GameOver
{
    SKLabelNode *lbl;
    SKNode *touched;
}

//button creator
-(SKSpriteNode *)button:(NSString*)title pos:(CGPoint)position {
    
    SKSpriteNode *nodeImg = [SKSpriteNode spriteNodeWithImageNamed:@"buttons"];
    
    SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    titleLabel.text = title;
    titleLabel.fontColor = [SKColor whiteColor];
    titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    titleLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    titleLabel.name = title;
    
    [nodeImg addChild:titleLabel];
    [nodeImg setPosition:position];
    
    return nodeImg;
}

-(instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"menuBg.png"];
        background.anchorPoint = CGPointMake(0, 0);

        
        lbl = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        lbl.text = @"Game Over";
        lbl.position = CGPointMake(self.size.width/2, self.size.height - 200);
        lbl.fontColor = [SKColor whiteColor];
        lbl.fontSize = 50;
        
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        score.text = [NSString stringWithFormat:@"Score: %i", [Score shared].totalScore];
        score.position = CGPointMake(self.size.width/2, lbl.position.y - 40);
        score.fontColor = [SKColor whiteColor];
        
        SKSpriteNode *again = [self button:@"Play Again?" pos:CGPointMake(lbl.position.x, lbl.position.y - 120)];
        again.name = @"Play Again?";
        
        SKSpriteNode *menu = [self button:@"Main Menu" pos:CGPointMake(again.position.x, again.position.y - 100)];
        menu.name = @"Main Menu";
        
        [self addChild:background];
        [self addChild:lbl];
        [self addChild:again];
        [self addChild:menu];
        [self addChild:score];
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    touched = [self nodeAtPoint:location];
    
//    if ([touched.name isEqualToString:@"Play Again?"]) {
//        GameScene *scene = [GameScene sceneWithSize:self.size];
//        
//        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
//        
//        [self.view presentScene:scene transition:reveal];
//        
//    } else
    if ([touched.name isEqualToString:@"Main Menu"]) {
    
        Menu *scene = [Menu sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];
    }
    
}

@end
