//
//  Levels.m
//  pinball
//
//  Created by Kristie Syda on 9/3/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Levels.h"
#import "Menu.h"
#import "GameScene.h"

@implementation Levels

//star creator
-(SKSpriteNode *)star:(NSString*)title pos:(CGPoint)position {
   
    //title is the level number
    int levelNum = [title intValue];
    SKSpriteNode *nodeImg;
    
    SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    titleLabel.text = title;
    titleLabel.fontColor = [SKColor blackColor];
    titleLabel.position = CGPointMake(0, -15);
    
/* if the level number is greater than the level number
    saved in userdefaults than its not unlocked */

    if (levelNum > (level + 1)) {
        
        nodeImg = [SKSpriteNode spriteNodeWithImageNamed:@"star2.png"];

    } else {
        
        nodeImg = [SKSpriteNode spriteNodeWithImageNamed:@"star.png"];
        nodeImg.name = title;
        titleLabel.name = title;
    }
    
    [nodeImg addChild:titleLabel];
    [nodeImg setPosition:position];

    return nodeImg;
}


-(instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:size];
        background.anchorPoint = CGPointMake(0, 0);
        
        SKSpriteNode *back = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
        back.name = @"menu";
        back.position = CGPointMake(40, self.size.height-50);
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"American Typewriter"];
        title.text = @"Levels";
        title.fontSize = 50;
        title.position = CGPointMake(self.size.width/2, self.size.height - 65);
    
        NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
        level = [data integerForKey:@"passed"];
        
        star1 = [self star:@"1" pos:CGPointMake(80, self.size.height - 150)];
        star2 = [self star:@"2" pos:CGPointMake(150, self.size.height - 150)];
        star3 = [self star:@"3" pos:CGPointMake(220, self.size.height - 150)];
        
        [self addChild:background];
        [self addChild:back];
        [self addChild:title];
        [self addChild:star1];
        [self addChild:star2];
        [self addChild:star3];
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
  
    //Menu
    if ([touched.name isEqualToString:@"menu"]) {
        
        Menu *scene = [Menu sceneWithSize:self.size];
        [self.view presentScene:scene transition:reveal];
        
    } else if ([touched.name isEqualToString:@"1"]){
        
        GameScene *game = [[GameScene alloc]initWithSize:self.size level:@"1"];
        [self.view presentScene:game transition:reveal];
        
    } else if ([touched.name isEqualToString:@"2"]){
        
        GameScene *game = [[GameScene alloc]initWithSize:self.size level:@"2"];
        [self.view presentScene:game transition:reveal];
        
    } else if ([touched.name isEqualToString:@"3"]){
            
        GameScene *game = [[GameScene alloc]initWithSize:self.size level:@"3"];
        [self.view presentScene:game transition:reveal];
        
    } else {
        NSLog(@"Locked!");
    }
    
}













@end
