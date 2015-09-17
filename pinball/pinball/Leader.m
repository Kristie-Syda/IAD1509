//
//  Leader.m
//  pinball
//
//  Created by Kristie Syda on 9/13/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Leader.h"
#import "Menu.h"
#import <Parse/Parse.h>

@implementation Leader

-(void)didMoveToView:(SKView *)view{
    
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 500, 100)];
    myTable.delegate = self;
    [self.view addSubview:myTable];
    
}

-(instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:self.size];
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
//        PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//        testObject[@"foo"] = @"bar";
//        [testObject saveInBackground];
//        NSLog(@"ran test");

        [self.view presentScene:scene transition:reveal];
        
    }
    
}


@end
