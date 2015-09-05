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
        
        SKSpriteNode *star1 = [SKSpriteNode spriteNodeWithImageNamed:@"star1.png"];
        star1.position = CGPointMake(80, self.size.height - 150);
        star1.name = @"star1";
        
        [self addChild:background];
        [self addChild:back];
        [self addChild:title];
        [self addChild:star1];
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
        
    } else {
        
        //levels
        NSString *lvl;
        
        
        if ([touched.name isEqualToString:@"star1"]){
            
            lvl = @"1";
            
        } else if ([touched.name isEqualToString:@"star2"]){
            
            lvl = @"2";
            
        }
        
        GameScene *game = [[GameScene alloc]initWithSize:self.size level:lvl];
        [self.view presentScene:game transition:reveal];
        
    }
    
}













@end
