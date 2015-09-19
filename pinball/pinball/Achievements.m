//
//  Achievements.m
//  pinball
//
//  Created by Kristie Syda on 9/18/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Achievements.h"
#import "Menu.h"

@implementation Achievements
-(instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"menuBg.png"];
        background.anchorPoint = CGPointMake(0, 0);
        
        SKLabelNode *lbl = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        lbl.text = @"Achievements";
        lbl.position = CGPointMake(self.size.width/2 + 20, self.size.height - 55);
        lbl.fontColor = [SKColor whiteColor];
        lbl.fontSize = 38;

        
        SKSpriteNode *back = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
        back.name = @"menu";
        back.position = CGPointMake(40, self.size.height-45);
        
        [self addChild:background];
        [self addChild:lbl];
        [self addChild:back];
    }
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    if ([touched.name isEqualToString:@"menu"]) {
        Menu *scene = [Menu sceneWithSize:self.size];
        
        SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];
        
    }
    
}

@end
