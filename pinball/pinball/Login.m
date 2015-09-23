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

// didMoveToView
//
// textfields cant be added to a SKScene
//
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
    
    [self.view addSubview:userName];
    [self.view addSubview:password];
}


// textfield methods for keyboard
//
// So the return key will close keyboard
//
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

// label maker
//
// creates all the labels above the textfields
//
-(SKLabelNode *)labelMaker:(NSString *)title position:(CGPoint)pos {
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        label.text = title;
        label.position = pos;
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 14;
        return label;
}

// init Method
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

// logging in method
//
// shows a pop up alert & Exits to menu
// Had to be a UIAlertController VS UIAlertView -- UIAlertView is deprecated in iOS 8
//
-(void)loggedIn{
    UIAlertController *toastMsg = [UIAlertController alertControllerWithTitle:@"Please wait" message:@"Logging in..." preferredStyle:UIAlertControllerStyleAlert];
   
    [self.view.window.rootViewController presentViewController:toastMsg animated:YES completion:nil];
    int duration = 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(),
                ^{
                    [toastMsg dismissViewControllerAnimated:YES completion:nil];
                });
    //opens menu
    Menu *scene = [Menu sceneWithSize:self.size];
    SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:2];
    [self.view presentScene:scene transition:reveal];
    [self resetView];
}


// touches began
//
// For the buttons - Menu & Submit
//
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //Menu
    if ([touched.name isEqualToString:@"menu"]) {
        [self resetView];
        Menu *scene = [Menu sceneWithSize:self.size];
        SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:2];
        [self.view presentScene:scene transition:reveal];
        
    //log in
    } else if ([touched.name isEqualToString:@"submit"]){
        [PFUser logInWithUsernameInBackground:userName.text password:password.text
                block:^(PFUser *player, NSError *error) {
                    if (player) {
                        //set current user
                        [PFUser becomeInBackground:[player sessionToken] block:^(PFUser *user, NSError *error) {
                            if (error) {
                                // UIAlertController with action added to GameViewController
                                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:[error userInfo][@"error"] preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
                                [errorAlert addAction: defaultAction];
                                [self.view.window.rootViewController presentViewController:errorAlert animated:YES completion:nil];

                            } else {
                                [self loggedIn];
                            }
                        }];
                            
                    } else {
            
                        // UIAlertController with action added to GameViewController
                        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"wrong username or password, please try again" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
                        [errorAlert addAction: defaultAction];
                        [self.view.window.rootViewController presentViewController:errorAlert animated:YES completion:nil];
                    }
        }];
    }
}

@end
