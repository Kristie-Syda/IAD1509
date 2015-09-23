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
#import <Parse/Parse.h>

@implementation Levels

#pragma mark - Scene Setup

// Star creator
//
//  Depending on the level number user is on decides
//  which star image to use.
//
//  If the level number is greater than the saved level
//  in userdefaults/user account than its not unlocked
//
//  Example: level 5 > saved level 6 = level 5 is unlocked
//  star image should be yellow and available to be clicked on.
//
-(SKSpriteNode *)star:(NSString*)title pos:(CGPoint)position {
   
    //title is the level number
    int levelNum = [title intValue];
    int savedlevel = [level intValue];
    
    SKSpriteNode *nodeImg;
    SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    titleLabel.text = title;
    titleLabel.fontColor = [SKColor blackColor];
    titleLabel.position = CGPointMake(0, -15);

/*  Example: level 5 > saved level 6 = level 5 is unlocked
    star image should be yellow and available to be clicked on. */
    if (levelNum > (savedlevel)) {
        nodeImg = [SKSpriteNode spriteNodeWithImageNamed:@"star2.png"];
    } else {
        nodeImg = [SKSpriteNode spriteNodeWithImageNamed:@"star.png"];
        nodeImg.name = title;
        titleLabel.name = title;
    }
    nodeImg.size = CGSizeMake(75, 75);
    [nodeImg addChild:titleLabel];
    [nodeImg setPosition:position];
    return nodeImg;
}

// init Method
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
        
        PFUser *currentUser = [PFUser currentUser];
        
        //grab current user data
        if(currentUser) {
            
            //Find the player id that matches current user object id
            PFQuery *queryId = [PFQuery queryWithClassName:@"HighScore"];
            [queryId whereKey:@"playerId" equalTo:[currentUser objectId]];

            [queryId findObjectsInBackgroundWithBlock:^(NSArray *players, NSError *error) {
                if (!error) {
                    
                    int lvl = 0;
                    
                    //grab the player's objectId
                    for (PFObject *data in players) {
                        
                        //store id and level
                        playerId = [data objectId];
                        lvl = [data[@"Level"]intValue];
                    }
                    
                /* If level is 0, add 1 so when creating the stars
                    the first level will be unlocked */
                    if (lvl == 0){
                        level = [NSNumber numberWithInt:lvl + 1];
                    } else {
                         level = [NSNumber numberWithInt:lvl];
                    }
                    
                    //add stars to scene -- have to add code to completion block
                    star1 = [self star:@"1" pos:CGPointMake(55, self.size.height - 150)];
                    star2 = [self star:@"2" pos:CGPointMake(140, self.size.height - 150)];
                    star3 = [self star:@"3" pos:CGPointMake(225, self.size.height - 150)];
                    star4 = [self star:@"4" pos:CGPointMake(315, self.size.height - 150)];
                    star5 = [self star:@"5" pos:CGPointMake(55, self.size.height - 250)];
                    star6 = [self star:@"6" pos:CGPointMake(140, self.size.height - 250)];
                    star7 = [self star:@"7" pos:CGPointMake(225, self.size.height - 250)];
                    star8 = [self star:@"8" pos:CGPointMake(315, self.size.height - 250)];
                    star9 = [self star:@"9" pos:CGPointMake(55, self.size.height - 350)];
                    star10 = [self star:@"10" pos:CGPointMake(140, self.size.height - 350)];
                    
                    [self addChild:background];
                    [self addChild:back];
                    [self addChild:title];
                    [self addChild:star1];
                    [self addChild:star2];
                    [self addChild:star3];
                    [self addChild:star4];
                    [self addChild:star5];
                    [self addChild:star6];
                    [self addChild:star7];
                    [self addChild:star8];
                    [self addChild:star9];
                    [self addChild:star10];
                    
                } else {
                    NSLog(@"Error");
                }
            }];
   
        //guest user
        } else if (!currentUser) {
            // Grabs level for device
            NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
            level = [NSNumber numberWithInteger:[data integerForKey:@"passed"]];
            
            star1 = [self star:@"1" pos:CGPointMake(55, self.size.height - 150)];
            star2 = [self star:@"2" pos:CGPointMake(140, self.size.height - 150)];
            star3 = [self star:@"3" pos:CGPointMake(225, self.size.height - 150)];
            star4 = [self star:@"4" pos:CGPointMake(315, self.size.height - 150)];
            star5 = [self star:@"5" pos:CGPointMake(55, self.size.height - 250)];
            star6 = [self star:@"6" pos:CGPointMake(140, self.size.height - 250)];
            star7 = [self star:@"7" pos:CGPointMake(225, self.size.height - 250)];
            star8 = [self star:@"8" pos:CGPointMake(315, self.size.height - 250)];
            star9 = [self star:@"9" pos:CGPointMake(55, self.size.height - 350)];
            star10 = [self star:@"10" pos:CGPointMake(140, self.size.height - 350)];
            
            [self addChild:background];
            [self addChild:back];
            [self addChild:title];
            [self addChild:star1];
            [self addChild:star2];
            [self addChild:star3];
            [self addChild:star4];
            [self addChild:star5];
            [self addChild:star6];
            [self addChild:star7];
            [self addChild:star8];
            [self addChild:star9];
            [self addChild:star10];
        }
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
    GameScene *game = [[GameScene alloc]initWithSize:self.size level:touched.name];
  
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
    } else if([touched.name isEqualToString:@"5"]){
        [self.view presentScene:game transition:reveal];
    //Level 6
    } else if([touched.name isEqualToString:@"6"]){
        [self.view presentScene:game transition:reveal];
    //Level 7
    } else if([touched.name isEqualToString:@"7"]){
        [self.view presentScene:game transition:reveal];
    //Level 8
    } else if([touched.name isEqualToString:@"8"]){
        [self.view presentScene:game transition:reveal];
    //Level 9
    } else if([touched.name isEqualToString:@"9"]){
        [self.view presentScene:game transition:reveal];
    //Level 10
    } else if([touched.name isEqualToString:@"10"]){
        [self.view presentScene:game transition:reveal];
    } else {
        NSLog(@"Locked!");
    }
}


@end
