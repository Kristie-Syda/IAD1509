//
//  Login.m
//  pinball
//
//  Created by Kristie Syda on 9/14/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Login.h"
#import "Menu.h"
#import <Parse/Parse.h>

@implementation Login


-(void)didMoveToView:(SKView *)view {
    
   
    //Username
    userName = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 + 40, 150, 30)];
    userName.placeholder = @"UserName";
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.backgroundColor = [UIColor lightGrayColor];
    userName.textColor = [UIColor blackColor];
    
    //Password
    password = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 + 110, 150, 30)];
    password.placeholder = @"Password";
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.backgroundColor = [UIColor lightGrayColor];
    password.textColor = [UIColor blackColor];
    
    alertView = [[UIAlertView alloc] initWithTitle:@"Please leave no blank boxess" message:@"Your message is this message" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    

    [self.view addSubview:userName];
    [self.view addSubview:password];
    
}

-(SKLabelNode *)labelMaker:(NSString *)title position:(CGPoint)pos {
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    label.text = title;
    label.position = pos;
    label.fontColor = [SKColor whiteColor];
    label.fontSize = 14;
    
    return label;
}


-(instancetype)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"menuBg.png"];
        background.anchorPoint = CGPointMake(0, 0);
        
        lbl = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        lbl.text = @"Login";
        lbl.position = CGPointMake(self.size.width/2, self.size.height - 60);
        lbl.fontColor = [SKColor whiteColor];
        lbl.fontSize = 50;
               
        SKSpriteNode *back = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
        back.name = @"menu";
        back.position = CGPointMake(40, self.size.height-50);
        
        
        //Introduction label
        SKLabelNode *intro = [self labelMaker:@"Please fill out form to register" position:CGPointMake(self.size.width/2, self.size.height - 160)];
        intro.fontSize = 20;
        
        //labels
        userLabel = [self labelMaker:@"Username:" position:CGPointMake(82, self.size.height/2 - 35)];
        passwordLabel = [self labelMaker:@"Password:" position:CGPointMake(82, self.size.height/2 - 105)];

        //submit button
        SKSpriteNode *submit = [SKSpriteNode spriteNodeWithImageNamed:@"buttons.png"];
        submit.position = CGPointMake(self.size.width/2, self.size.height/2 - 200);
        submit.size = CGSizeMake(200, 65);
        submit.name = @"submit";
        
        //label on submit button
        SKLabelNode *submitLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        submitLabel.text = @"Submit";
        submitLabel.name = @"submit";
        submitLabel.fontColor = [SKColor whiteColor];
        submitLabel.position = CGPointMake(0, -10);
        
        //add label to button
        [submit addChild:submitLabel];

        
        [self addChild:background];
        [self addChild:lbl];
        [self addChild:back];
        [self addChild:intro];
        [self addChild:submit];
        [self addChild:userLabel];
        [self addChild:passwordLabel];
        
        
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
        
    } else if ([touched.name isEqualToString:@"submit"]){
        
        [PFUser logInWithUsernameInBackground:userName.text password:password.text
                block:^(PFUser *user, NSError *error) {
                        if (user) {
                            
                            
                            NSLog(@"logged in");
                            
                            } else {
                                
                               UIAlertView *errorMsg = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"wrong username or password, please try again" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                                
                                [errorMsg show];
                                
                            }
                        }];
    }
    
}


@end
