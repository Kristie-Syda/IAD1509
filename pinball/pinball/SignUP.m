//
//  SignUP.m
//  pinball
//
//  Created by Kristie Syda on 9/14/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "SignUP.h"
#import "Menu.h"
#import <Parse/Parse.h>

@implementation SignUP

-(void)didMoveToView:(SKView *)view {
    
    //Firstname
    firstName = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 - 100, 130, 30)];
    firstName.placeholder = @"First Name";
    firstName.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstName.borderStyle = UITextBorderStyleRoundedRect;
    firstName.backgroundColor = [UIColor lightGrayColor];
    firstName.textColor = [UIColor blackColor];
    
    //Lastname
    lastName = [[UITextField alloc]initWithFrame:CGRectMake(205, self.size.height/2 - 100, 120, 30)];
    lastName.placeholder = @"Last Name";
    lastName.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastName.borderStyle = UITextBorderStyleRoundedRect;
    lastName.backgroundColor = [UIColor lightGrayColor];
    lastName.textColor = [UIColor blackColor];
    
    //Email
    email = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 - 30, 250, 30)];
    email.placeholder = @"Email Address";
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.backgroundColor = [UIColor lightGrayColor];
    email.textColor = [UIColor blackColor];
    
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

    alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please leave no boxes empty" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    
    saved = [[UIAlertView alloc]initWithTitle:@"Information Saved!" message:@"You are now a member of Flip Ball" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    
    [self.view addSubview:firstName];
    [self.view addSubview:lastName];
    [self.view addSubview:email];
    [self.view addSubview:userName];
    [self.view addSubview:password];
    
}

-(void)resetView {
    
    [firstName removeFromSuperview];
    [lastName removeFromSuperview];
    [email removeFromSuperview];
    [userName removeFromSuperview];
    [password removeFromSuperview];
}

-(void)resetText {
    
    firstName.text = @"";
    lastName.text = @"";
    email.text = @"";
    userName.text = @"";
    password.text = @"";
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
        
        //Sign Up label
        SKLabelNode *mainLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        mainLabel.text = @"Sign Up";
        mainLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        mainLabel.position = CGPointMake(self.size.width/2, self.size.height - 60);
        mainLabel.fontSize = 50;
        
        //Introduction label
        intro = [self labelMaker:@"Please fill out form to register" position:CGPointMake(self.size.width/2, self.size.height - 160)];
        intro.fontSize = 20;
        
        //title labels
        first = [self labelMaker:@"First Name:" position:CGPointMake(82, self.size.height/2 + 106)];
        last = [self labelMaker:@"Last Name:" position:CGPointMake(242, self.size.height/2 + 106)];
        emailLabel = [self labelMaker:@"Email:" position:CGPointMake(65, self.size.height/2 + 36)];
        userLabel = [self labelMaker:@"Username:" position:CGPointMake(82, self.size.height/2 - 35)];
        passwordLabel = [self labelMaker:@"Password:" position:CGPointMake(82, self.size.height/2 - 105)];
        
        //back button
        SKSpriteNode *back = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
        back.name = @"menu";
        back.position = CGPointMake(40, self.size.height-50);
        
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
        [self addChild:mainLabel];
        [self addChild:back];
        [self addChild:submit];
        [self addChild:intro];
        [self addChild:first];
        [self addChild:last];
        [self addChild:emailLabel];
        [self addChild:userLabel];
        [self addChild:passwordLabel];
    }
    
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //menu transition
    if ([touched.name isEqualToString:@"menu"]) {
        
        Menu *scene = [Menu sceneWithSize:self.size];
        
        //reset view
        [self resetView];
        
        SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        
        [self.view presentScene:scene transition:reveal];
    
    //submit button pressed
    } else if ([touched.name isEqualToString:@"submit"]){
        
        //checking for blanks
        if ([firstName.text isEqualToString:@""]) {
           
            [alertView show];
         
        } else if ([email.text isEqualToString:@""]) {
            
            [alertView show];
        
        } else if ([password.text isEqualToString:@""]){
            
            [alertView show];
        
        } else {
            
            PFUser *player = [PFUser user];
            
            player[@"First"] = firstName.text;
            player[@"Last"] = lastName.text;
            player.username = userName.text;
            player.password = password.text;
            player.email = email.text;
            
            [player signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    
                    [self resetText];
                    NSLog(@"ran test");
                    
                    [saved show];

                } else {
                    
                    errorString = [error userInfo][@"error"];
                   
                    errorMsg = [[UIAlertView alloc]initWithTitle:@"Error!" message:errorString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];

                    [errorMsg show];
                }
            }];
        }
        
    }
    
}


@end
