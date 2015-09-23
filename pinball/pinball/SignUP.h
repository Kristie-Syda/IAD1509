//
//  SignUP.h
//  pinball
//
//  Created by Kristie Syda on 9/14/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Parse/Parse.h>

@interface SignUP : SKScene <UITextFieldDelegate>
{
    UITextField *firstName;
    UITextField *lastName;
    UITextField *email;
    UITextField *userName;
    UITextField *password;
    SKLabelNode *intro;
    SKLabelNode *first;
    SKLabelNode *last;
    SKLabelNode *emailLabel;
    SKLabelNode *userLabel;
    SKLabelNode *passwordLabel;
    UIAlertController *alert;
}

@property(nonatomic,strong)PFGeoPoint *userLocation;

@end
