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
#import "Score.h"

@implementation Levels

//star creator
-(SKSpriteNode *)star:(NSString*)title pos:(CGPoint)position {
   
    //title is the level number
    int levelNum = [title intValue];
    SKSpriteNode *nodeImg;
    
    SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    titleLabel.text = title;
    titleLabel.fontColor = [SKColor blackColor];
    titleLabel.position = CGPointMake(-2, -15);
    
/* if the level number is greater than the level number 
   that is saved in userdefaults than its not unlocked */

    if (levelNum > (level + 1)) {
        
        nodeImg = [SKSpriteNode spriteNodeWithImageNamed:@"star2.png"];

    } else {
        
        nodeImg = [SKSpriteNode spriteNodeWithImageNamed:@"star.png"];
        nodeImg.name = title;
        titleLabel.name = title;
    }
    
    nodeImg.size = CGSizeMake(70, 70);
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
        
        SKLabelNode *reset = [SKLabelNode labelNodeWithFontNamed:@"American Typewriter"];
        reset.text = @"Reset";
        reset.fontSize = 50;
        reset.position = CGPointMake(self.size.width/2, self.size.height/3);
        reset.name = @"reset";
        
        NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
        level = [data integerForKey:@"passed"];
        
        star1 = [self star:@"1" pos:CGPointMake(55, self.size.height - 150)];
        star2 = [self star:@"2" pos:CGPointMake(140, self.size.height - 150)];
        star3 = [self star:@"3" pos:CGPointMake(225, self.size.height - 150)];
        star4 = [self star:@"4" pos:CGPointMake(315, self.size.height - 150)];
        star5 = [self star:@"5" pos:CGPointMake(55, self.size.height - 250)];
        star6 = [self star:@"6" pos:CGPointMake(140, self.size.height - 250)];
        
        
        [self addChild:background];
        [self addChild:back];
        [self addChild:title];
        [self addChild:star1];
        [self addChild:star2];
        [self addChild:star3];
        [self addChild:star4];
        [self addChild:star5];
        [self addChild:star6];
        [self addChild:reset];
        
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
    GameScene *game = [[GameScene alloc]initWithSize:self.size level:touched.name];
  
    NSLog(@"%@",touched.name);
    
    //Menu
    if ([touched.name isEqualToString:@"menu"]) {
        
        Menu *scene = [Menu sceneWithSize:self.size];
        [self.view presentScene:scene transition:reveal];
    
    //Level 1
    } else if ([touched.name isEqualToString:@"1"]){
        
        [self.view presentScene:game transition:reveal];
    
    //Level 2
    } else if ([touched.name isEqualToString:@"2"]){
        
        [self.view presentScene:game transition:reveal];
    
    //Level 3
    } else if ([touched.name isEqualToString:@"3"]){
        
        [self.view presentScene:game transition:reveal];
    
    //Level 4
    } else if([touched.name isEqualToString:@"4"]){
        
         [self.view presentScene:game transition:reveal];
    
    //lLevel 5
    }else if([touched.name isEqualToString:@"5"]){
    
        [self.view presentScene:game transition:reveal];
        
    //Level 6
    }else if([touched.name isEqualToString:@"6"]){
    
        [self.view presentScene:game transition:reveal];
    
    //reset
    }else if([touched.name isEqualToString:@"reset"]){
        
        NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
        [data setInteger:0 forKey:@"passed"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        Levels *scene = [[Levels alloc]initWithSize:self.size];
        [self.view presentScene:scene];
        
    } else {
        NSLog(@"Locked!");
    }
    
}













@end
