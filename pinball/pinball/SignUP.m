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

// didMoveToView
//
// textfields cant be added to a SKScene
//
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

    [self.view addSubview:firstName];
    [self.view addSubview:lastName];
    [self.view addSubview:email];
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

//removes the textfields off view when done
-(void)resetView {
    [firstName removeFromSuperview];
    [lastName removeFromSuperview];
    [email removeFromSuperview];
    [userName removeFromSuperview];
    [password removeFromSuperview];
}


#pragma mark - SKScene Setup

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

// Alert Method 
//
// easier to present UIAlertController
//
-(void)alertShow {
    
    // UIAlertController with action added to GameViewController
    alert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Please leave no empty boxes" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction: defaultAction];

    [self.view.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


// SignIn Method
//
// Informs user of account created & goes to menu
// Had to be a UIAlertController VS UIAlertView -- UIAlertView is deprecated in iOS 8
//
-(void)SignedIn{
    UIAlertController *saved = [UIAlertController alertControllerWithTitle:@"Information Saved!" message:@"You can now use your Flipball account" preferredStyle:UIAlertControllerStyleAlert];
    
    [self.view.window.rootViewController presentViewController:saved animated:YES completion:nil];
    int duration = 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(),
                   ^{
                       [saved dismissViewControllerAnimated:YES completion:nil];
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
// Submit button - Creates all parse objects (User, Highscore and Achievements)
//
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
            [self alertShow];
        } else if ([email.text isEqualToString:@""]) {
            [self alertShow];
        } else if ([password.text isEqualToString:@""]){
            [self alertShow];
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
                            //PFGeoPoint *makeUp = [PFGeoPoint geoPointWithLatitude:37.785834 longitude:122.406417];
                            
                            //add in game info to HighScore and pass current user data also
                            PFObject *data = [PFObject objectWithClassName:@"HighScore"];
                            data[@"Score"] = [NSNumber numberWithInt:0];
                            data[@"Player"] = current;
                            data[@"Level"] = [NSNumber numberWithInt:0];
                            data[@"playerId"] = [current objectId];
                            data[@"Username"] = [current username];
                            data[@"Location"] = point;
                            [data saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            }];
                            
                            //create achievement objects
                            PFObject *info = [PFObject objectWithClassName:@"Achievements"];
                            [info setObject:[PFUser currentUser] forKey:@"Player"];
                            
                            info[@"PlayerId"] = [current objectId];
                            info[@"Username"] = userName.text;
                            info[@"ach1"] = [NSNumber numberWithBool:NO];
                            info[@"ach2"] = [NSNumber numberWithBool:NO];
                            info[@"ach3"] = [NSNumber numberWithBool:NO];
                            info[@"ach4"] = [NSNumber numberWithBool:NO];
                            info[@"ach5"] = [NSNumber numberWithBool:NO];
                            info[@"ach6"] = [NSNumber numberWithBool:NO];
                            info[@"ach7"] = [NSNumber numberWithBool:NO];
                            info[@"ach8"] = [NSNumber numberWithBool:NO];
                            info[@"ach9"] = [NSNumber numberWithBool:NO];
                            info[@"ach10"] = [NSNumber numberWithBool:NO];
                            [info saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            }];
                        }];
                    } else {
                        NSLog(@"highscore object Not created");
                    }
                    //sign in method
                    [self SignedIn];
                    
                //Error for [player signUpInBackgroundWithBlock]
                } else {
                    
                    // UIAlertController with action added to GameViewController
                    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:[error userInfo][@"error"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
                    [errorAlert addAction: defaultAction];
                    [self.view.window.rootViewController presentViewController:errorAlert animated:YES completion:nil];
                }
            }];
        }
    }
}


@end
