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
#import "Score.h"

@implementation SignUP

#pragma mark - UITextfields

//have to put UITextfields here because they dont show up on SKScenes
-(void)didMoveToView:(SKView *)view {
    
    //Firstname
    firstName = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 - 155, 130, 30)];
    firstName.placeholder = @"First Name";
    firstName.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstName.borderStyle = UITextBorderStyleRoundedRect;
    firstName.backgroundColor = [UIColor lightGrayColor];
    firstName.textColor = [UIColor blackColor];
    firstName.delegate = self;
    firstName.tag = 1;
    
    //Lastname
    lastName = [[UITextField alloc]initWithFrame:CGRectMake(205, self.size.height/2 - 155, 120, 30)];
    lastName.placeholder = @"Last Name";
    lastName.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastName.borderStyle = UITextBorderStyleRoundedRect;
    lastName.backgroundColor = [UIColor lightGrayColor];
    lastName.textColor = [UIColor blackColor];
    lastName.delegate = self;
    
    //Email
    email = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 - 85, 250, 30)];
    email.placeholder = @"Email Address";
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.backgroundColor = [UIColor lightGrayColor];
    email.textColor = [UIColor blackColor];
    email.delegate = self;
    
    //Username
    userName = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 - 15, 150, 30)];
    userName.placeholder = @"UserName";
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.backgroundColor = [UIColor lightGrayColor];
    userName.textColor = [UIColor blackColor];
    userName.delegate = self;
    
    //Password
    password = [[UITextField alloc]initWithFrame:CGRectMake(45, self.size.height/2 + 45, 150, 30)];
    password.placeholder = @"Password";
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.backgroundColor = [UIColor lightGrayColor];
    password.textColor = [UIColor blackColor];
    password.delegate = self;
    password.tag = 5;

    alertView = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please leave no boxes empty" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    
    [self.view addSubview:firstName];
    [self.view addSubview:lastName];
    [self.view addSubview:email];
    [self.view addSubview:userName];
    [self.view addSubview:password];
    
}

//textfields methods for keyboard
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField
{
    [textField resignFirstResponder];
    return YES;
}

//removes the textfields off view when done
-(void)resetView {
    
    [firstName removeFromSuperview];
    [lastName removeFromSuperview];
    [email removeFromSuperview];
    [userName removeFromSuperview];
    [password removeFromSuperview];
}

#pragma mark - SKScene Setup

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
        
        //Sign Up label
        SKLabelNode *mainLabel = [SKLabelNode labelNodeWithFontNamed:@"AmericanTypeWriter"];
        mainLabel.text = @"Sign Up";
        mainLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        mainLabel.position = CGPointMake(self.size.width/2, self.size.height - 60);
        mainLabel.fontSize = 50;
        
        //Introduction label
        intro = [self labelMaker:@"Please fill out form to register" position:CGPointMake(self.size.width/2, self.size.height - 135)];
        intro.fontSize = 20;
        
        //title labels
        first = [self labelMaker:@"First Name:" position:CGPointMake(82, self.size.height/2 + 160)];
        last = [self labelMaker:@"Last Name:" position:CGPointMake(242, self.size.height/2 + 160)];
        emailLabel = [self labelMaker:@"Email:" position:CGPointMake(65, self.size.height/2 + 90)];
        userLabel = [self labelMaker:@"Username:" position:CGPointMake(82, self.size.height/2 + 20)];
        passwordLabel = [self labelMaker:@"Password:" position:CGPointMake(82, self.size.height/2 - 40)];
        
        //back button
        SKSpriteNode *back = [SKSpriteNode spriteNodeWithImageNamed:@"back.png"];
        back.name = @"menu";
        back.position = CGPointMake(40, self.size.height-50);
        
        //submit button
        SKSpriteNode *submit = [SKSpriteNode spriteNodeWithImageNamed:@"buttons.png"];
        submit.position = CGPointMake(self.size.width/2, self.size.height/2 - 180);
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

#pragma mark SKScene Methods

//player is signed up and ready to use account
-(void)SignedIn{
    //saved alert and dialog
    saved = [[UIAlertView alloc]initWithTitle:@"Information Saved!" message:@"You can now use your Flipball account" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    saved.backgroundColor = [UIColor blackColor];
    [saved show];
    int duration = 3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(),
                   ^{
                       [saved dismissWithClickedButtonIndex:0 animated:YES];
                   });
    //opens menu
    Menu *scene = [Menu sceneWithSize:self.size];
    SKTransition *reveal = [SKTransition doorsCloseHorizontalWithDuration:2];
    [self.view presentScene:scene transition:reveal];
    [self resetView];
}

//Touches began -- back and submit button
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *touched = [self nodeAtPoint:location];
    
    //menu transition
    if ([touched.name isEqualToString:@"menu"]) {
        //reset view
        [self resetView];
        
        Menu *scene = [Menu sceneWithSize:self.size];
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
            //creating User
            PFUser *player = [PFUser user];
            player[@"First"] = firstName.text;
            player[@"Last"] = lastName.text;
            player.username = userName.text;
            player.password = password.text;
            player.email = email.text;
            
            [player signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    
                    PFObject *data= [PFObject objectWithClassName:@"HighScore"];
                    [data setObject:[PFUser currentUser] forKey:@"Player"];
                    
                    //create highscore object for new user
                    PFUser *current = [PFUser currentUser];
                    if (current) {
                        
                        [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *point, NSError *err){

                            //make up imaginary locations for fake users -- debugging purposes
                            //PFGeoPoint *makeUp = [PFGeoPoint geoPointWithLatitude:-89.42 longitude:67.5];
                            
                            //add in game info to HighScore and pass current user data also
                            PFObject *data = [PFObject objectWithClassName:@"HighScore"];
                            data[@"Score"] = [NSNumber numberWithInt:0];
                            data[@"Player"] = current;
                            data[@"Level"] = [NSNumber numberWithInt:0];
                            data[@"playerId"] = [current objectId];
                            data[@"Username"] = [current username];
                            data[@"Location"] = point;

                            [data saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                NSLog(@"highscore object created");
                            }];
                            
                            //create achievement objects
                            PFObject *info = [PFObject objectWithClassName:@"Achievements"];
                            [info setObject:[PFUser currentUser] forKey:@"Player"];
                            
                            info[@"PlayerId"] = [current objectId];
                            info[@"ach1"] = [NSNumber numberWithBool:NO];
                            info[@"ach2"] = [NSNumber numberWithBool:NO];
                            
                            [info saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            }];
                        }];
                    } else {
                        NSLog(@"highscore object Not created");
                    }
                    //sign in method
                    [self SignedIn];
                } else {
                    //error msg
                    errorString = [error userInfo][@"error"];
                    errorMsg = [[UIAlertView alloc]initWithTitle:@"Error!" message:errorString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                    [errorMsg show];
                }
            }];
        }
    }
}


@end
