//
//  Menu.m
//  pinball
//
//  Created by Kristie Syda on 8/24/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Menu.h"
#import "GameScene.h"
#import "Score.h"
#import "InstScene.h"
#import "Credits.h"
#import "Levels.h"

@implementation Menu



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
        
        //background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"menuBg.png"];
        background.anchorPoint = CGPointMake(0, 0);
        
        //Main menu label
        SKLabelNode *mainLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        mainLabel.text = @"Main Menu";
        mainLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        mainLabel.position = CGPointMake(self.size.width/2, self.size.height - 200);
             
             //play button
             play = [self button:@"New Game" pos:CGPointMake(self.size.width/2 - 5, mainLabel.position.y - 100)];
             play.name = @"New Game";
        
             //Levels button
             levels = [self button:@"Levels" pos:CGPointMake(play.position.x, play.position.y - 100)];
             levels.name = @"Levels";
        
             //instructions button
             instructions = [self button:@"Instructions" pos:CGPointMake(levels.position.x, levels.position.y - 100)];
             instructions.name = @"Instructions";
             
             //credits button
             credits = [self button:@"Credits" pos:CGPointMake(instructions.position.x, instructions.position.y - 100)];
             credits.name = @"Credits";
        
        [self addChild:background];
        [self addChild:mainLabel];
        [self addChild:play];
        [self addChild:levels];
        [self addChild:instructions];
        [self addChild:credits];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Game transition
    if ([touched.name isEqualToString:@"New Game"]) {
        
        GameScene *scene = [[GameScene alloc]initWithSize:self.size level:@"1"];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];
    
    //Levels transition
    } else if ([touched.name isEqualToString:@"Levels"]){
        
        Levels *scene = [Levels sceneWithSize:self.size];
        
        SKTransition *trans = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:trans];
        
    //Instruction transition
    } else if ([touched.name isEqualToString:@"Instructions"]){
        
        InstScene *scene = [InstScene sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];

    //Credits transition
    } else if ([touched.name isEqualToString:@"Credits"]){
        
        Credits *scene = [Credits sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];        
    }
}

@end
