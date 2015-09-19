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
#import "Score.h"

@implementation Login


#pragma mark - UITextfields

-(void)didMoveToView:(SKView *)view {
    
    //Username
    userName = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 - 60, 150, 30)];
    userName.placeholder = @"UserName";
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.backgroundColor = [UIColor lightGrayColor];
    userName.textColor = [UIColor blackColor];
    userName.delegate = self;
    
    //Password
    password = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 + 10, 150, 30)];
    password.placeholder = @"Password";
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.backgroundColor = [UIColor lightGrayColor];
    password.textColor = [UIColor blackColor];
    password.delegate = self;
    
    alertView = [[UIAlertView alloc] initWithTitle:@"Please leave no blank boxess" message:@"Your message is this message" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];

    [self.view addSubview:userName];
    [self.view addSubview:password];
}

//textfield methods for keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//Removes textfields off scene when done
-(void)resetView {
    
    [userName removeFromSuperview];
    [password removeFromSuperview];
}

#pragma mark - SKScene SetUp

//label maker
-(SKLabelNode *)labelMaker:(NSString *)title position:(CGPoint)pos {
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
    label.text = title;
    label.position = pos;
    label.fontColor = [SKColor whiteColor];
    label.fontSize = 14;
    
    return label;
}

//init
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
        SKLabelNode *intro = [self labelMaker:@"Please fill out form to login" position:CGPointMake(self.size.width/2, self.size.height - 160)];
        intro.fontSize = 20;
        
        //labels
        userLabel = [self labelMaker:@"Username:" position:CGPointMake(82, self.size.height/2 + 65)];
        passwordLabel = [self labelMaker:@"Password:" position:CGPointMake(82, self.size.height/2 - 5)];

        //submit button
        SKSpriteNode *submit = [SKSpriteNode spriteNodeWithImageNamed:@"buttons.png"];
        submit.position = CGPointMake(self.size.width/2, self.size.height/2 - 100);
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

#pragma mark SKScene Methods

//loggin in method
-(void)loggedIn{
    
    //shows a pop up alert thats lets user know they are logging in
    UIAlertView *toastMsg = [[UIAlertView alloc]initWithTitle:nil message:@"Logging in..." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    toastMsg.backgroundColor = [UIColor blackColor];
    [toastMsg show];
    int duration = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(),
                   ^{
                       [toastMsg dismissWithClickedButtonIndex:0 animated:YES];
                   });
    //opens menu
    Menu *scene = [Menu sceneWithSize:self.size];
    SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:2];
    [self.view presentScene:scene transition:reveal];
    [self resetView];
}

//touches began
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];

    if ([touched.name isEqualToString:@"menu"]) {
        [self resetView];
        Menu *scene = [Menu sceneWithSize:self.size];
        SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:2];
        [self.view presentScene:scene transition:reveal];
        
    } else if ([touched.name isEqualToString:@"submit"]){
       
        //log in
        [PFUser logInWithUsernameInBackground:userName.text password:password.text
                block:^(PFUser *player, NSError *error) {
                    
                    if (player) {
                        
                        //set current user
                        [PFUser becomeInBackground:[player sessionToken] block:^(PFUser *user, NSError *error) {
                            if (error) {
                                    
                                UIAlertView *errorMsg = [[UIAlertView alloc]initWithTitle:@"Error!" message:[error userInfo][@"error"] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                                    
                                [errorMsg show];
                                    
                            } else {
                                
                                [self loggedIn];
                            }
                        }];
                            
                    } else {
                                
                        UIAlertView *errorMsg = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"wrong username or password, please try again" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                                
                        [errorMsg show];
                    }
        }];
    }
    
}

@end
