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
#import "Leader.h"
#import "Credits.h"
#import "Levels.h"
#import "SignUP.h"
#import <Parse/Parse.h>
#import "Login.h"

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
        mainLabel.position = CGPointMake(self.size.width/2, self.size.height - 60);
        mainLabel.fontSize = 50;
        
        SKLabelNode *welcome = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        welcome.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        welcome.position = CGPointMake(30, self.size.height - 115);
        welcome.fontSize = 20;

             //play button
             play = [self button:@"Play Game" pos:CGPointMake(self.size.width/2 - 5, mainLabel.position.y - 200)];
             play.name = @"Play Game";
        
             //Levels button
             levels = [self button:@"Levels" pos:CGPointMake(play.position.x, play.position.y - 100)];
             levels.name = @"Levels";
        
             //instructions button
             leader = [self button:@"LeaderBoards" pos:CGPointMake(levels.position.x, levels.position.y - 100)];
             leader.name = @"LeaderBoards";
             
             //credits button
             credits = [self button:@"Credits" pos:CGPointMake(leader.position.x, leader.position.y - 100)];
             credits.name = @"Credits";
        
        [self addChild:background];
        [self addChild:mainLabel];
        [self addChild:play];
        [self addChild:levels];
        [self addChild:leader];
        [self addChild:credits];
        
        currentUser = [PFUser currentUser];
       
        if (currentUser) {
           
            SKSpriteNode *logOff = [SKSpriteNode spriteNodeWithImageNamed:@"logOut"];
            logOff.position = CGPointMake(self.size.width - 60, self.size.height - 105);
            logOff.name = @"logOff";
            
            welcome.text = [NSString stringWithFormat:@"Welcome %@, ", [currentUser username]];
            
            [self addChild:logOff];
            [self addChild:welcome];
            
        } else if (!currentUser) {
            
            SKSpriteNode *login = [SKSpriteNode spriteNodeWithImageNamed:@"login.png"];
            login.position = CGPointMake(self.size.width - 60, self.size.height - 105);
            login.name = @"login";
            
            SKSpriteNode *signUp = [SKSpriteNode spriteNodeWithImageNamed:@"signUp.png"];
            signUp.position = CGPointMake(self.size.width - 170, self.size.height - 105);
            signUp.name = @"signUp";
            
            [self addChild:login];
            [self addChild:signUp];
        }
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Game transition on level 1 -- player gets 3 balls
    if ([touched.name isEqualToString:@"Play Game"]) {
        
        GameScene *scene = [[GameScene alloc]initWithSize:self.size level:@"1"];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];
    
    //Levels transition
    } else if ([touched.name isEqualToString:@"Levels"]){
        
        Levels *scene = [Levels sceneWithSize:self.size];
        
        SKTransition *trans = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:trans];
        
    //LeaderBoard transition
    } else if ([touched.name isEqualToString:@"LeaderBoards"]){
        
        Leader *scene = [Leader sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];

    //Credits transition
    } else if ([touched.name isEqualToString:@"Credits"]){
        
        Credits *scene = [Credits sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];
        
    //Sign Up
    } else if ([touched.name isEqualToString:@"signUp"]){
        
        SignUP *scene = [SignUP sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenVerticalWithDuration:0.5];
        
        [self.view presentScene:scene transition:reveal];
  
    } else if ([touched.name isEqualToString:@"login"]){
        
        Login *scene = [Login sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenVerticalWithDuration:0.5];
        
        [self.view presentScene:scene transition:reveal];
        
    } else if ([touched.name isEqualToString:@"logOff"]){
        
        [PFUser logOut];
        
        currentUser = [PFUser currentUser];
        
        Menu *scene = [Menu sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsOpenVerticalWithDuration:0.5];
        
        [self.view presentScene:scene transition:reveal];
       
    }
}

@end
