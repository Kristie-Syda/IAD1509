//
//  Credits.m
//  pinball
//
//  Created by Kristie Syda on 8/27/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Credits.h"
#import "Menu.h"

@implementation Credits

-(instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"creditBg.png"];
        background.anchorPoint = CGPointMake(0, 0);
        
        SKSpriteNode *back = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
        back.name = @"menu";
        back.position = CGPointMake(40, self.size.height-50);
        
        [self addChild:background];
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
