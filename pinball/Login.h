//
//  Login.h
//  pinball
//
//  Created by Kristie Syda on 9/14/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Login : SKScene
{
    SKLabelNode *lbl;
    UITextField *firstName;
    UITextField *lastName;
    UITextField *email;
    UITextField *userName;
    UITextField *password;
    UIAlertView * alertView;
    SKLabelNode *emailLabel;
    SKLabelNode *userLabel;
    SKLabelNode *passwordLabel;
}
@end
