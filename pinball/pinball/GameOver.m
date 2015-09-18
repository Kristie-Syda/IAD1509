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
#import <Parse/Parse.h>
#import "Login.h"



@implementation GameOver
{
    SKLabelNode *lbl;
    SKNode *touched;
    NSNumber *level;
    NSNumber *totalScore;
    NSString *playerId;
    FBSDKShareLinkContent *content;
    NSNumber *previousScore;
    NSNumber *previousLevel;
    FBSDKShareButton *shareButton;
}

-(void)didMoveToView:(SKView *)view{
    
    PFUser *current = [PFUser currentUser];
    if(current){
        content = [[FBSDKShareLinkContent alloc] init];
        content.contentURL = [NSURL
                          URLWithString:@"https://developers.facebook.com/apps/988202167888514/"];
        content.contentTitle = @"FlipBall";
        content.contentDescription = [NSString stringWithFormat:@"%@ just earned a score of %@ on FlipBall!", current.username,totalScore];
    
        shareButton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(self.size.width/2 - 35, self.size.height - 200, 100, 50)];
        shareButton.shareContent = content;
    
        [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
                
        [self.view addSubview:shareButton];
        
    } else {
         //no share button for guest
    }

}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    
}

-(void)share:(id)sender {
    
    [FBSDKShareDialog showFromViewController:self.view.window.rootViewController withContent:content delegate:self];
    
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
        
        NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
        
        level = [NSNumber numberWithFloat:[data integerForKey:@"passed"]];
        totalScore = [NSNumber numberWithInt:[Score shared].totalScore];
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"menuBg.png"];
        background.anchorPoint = CGPointMake(0, 0);

        lbl = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        lbl.text = @"Game Over";
        lbl.position = CGPointMake(self.size.width/2, self.size.height - 60);
        lbl.fontColor = [SKColor whiteColor];
        lbl.fontSize = 50;
        
        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        score.text = [NSString stringWithFormat:@"Score: %i", [Score shared].totalScore];
        score.position = CGPointMake(self.size.width/2, lbl.position.y - 100);
        score.fontColor = [SKColor whiteColor];
        
        SKSpriteNode *again = [self button:@"Try Again?" pos:CGPointMake(lbl.position.x, lbl.position.y - 220)];
        again.name = @"Try Again?";
        
        SKSpriteNode *menu = [self button:@"Main Menu" pos:CGPointMake(again.position.x, again.position.y - 100)];
        menu.name = @"Main Menu";

        [self addChild:background];
        [self addChild:lbl];
        [self addChild:again];
        [self addChild:menu];
        [self addChild:score];
        
        [self updateScore];
    }
    
    return self;
}

-(void)updateScore{
    
    PFUser *currentUser = [PFUser currentUser];
    
    //grab current user data
    if(currentUser) {
        
        //Find the player id that matches current user object id
        PFQuery *query = [PFQuery queryWithClassName:@"HighScore"];
        [query whereKey:@"playerId" equalTo:[currentUser objectId]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *players, NSError *error) {
            if (!error) {
                
                //grab the player's objectId
                for (PFObject *data in players) {
                    
                    //store id 
                    playerId = [data objectId];
                    previousScore = data[@"Score"];
                    previousLevel = data[@"Level"];
                }
                
                //update info
                PFQuery *data = [PFQuery queryWithClassName:@"HighScore"];
                [data getObjectInBackgroundWithId:playerId block:^(PFObject *player, NSError *error) {
                    
                    //player beat old score
                    if (previousScore < totalScore) {
                        
                        player[@"Score"] = totalScore;
                        UIAlertView *toastMsg = [[UIAlertView alloc]initWithTitle:@"New HighScore" message:@"updated on leaderboards" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                        toastMsg.backgroundColor = [UIColor blackColor];
                        [toastMsg show];
                        
                        int duration = 2;
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(),
                                       ^{
                                           [toastMsg dismissWithClickedButtonIndex:0 animated:YES];
                                       });

                    
                    //player beat old level
                    } else if (previousLevel < level) {
                        
                        player[@"Level"] = level;
                    }
                    
                    [player saveInBackground];
                    
                }];
            }
        }];
        
    } else if(!currentUser){
        //we dont save guest data
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    touched = [self nodeAtPoint:location];
    
    if ([touched.name isEqualToString:@"Try Again?"]) {
        
        [shareButton removeFromSuperview];
        
        GameScene *scene = [[GameScene alloc]initWithSize:self.size level:[NSString stringWithFormat:@"%i", [Score shared].currentLevel]];
        
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        [self.view presentScene:scene transition:reveal];
        
    } else if ([touched.name isEqualToString:@"Main Menu"]) {
        
        [shareButton removeFromSuperview];
        
        //go to menu
        Menu *scene = [Menu sceneWithSize:self.size];
        SKTransition *reveal = [SKTransition doorsOpenHorizontalWithDuration:2];
        
        [self.view presentScene:scene transition:reveal];
    }
    
}

@end
