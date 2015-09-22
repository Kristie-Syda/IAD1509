//
//  LeaderBoard.h
//  pinball
//
//  Created by Kristie Syda on 9/17/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "LBData.h"

@interface LeaderBoard : UIViewController <UITableViewDataSource, UITableViewDelegate,FBSDKSharingDelegate>
{
    IBOutlet UITableView *myTable;
    NSMutableArray *dataArray;
    IBOutlet UISwitch *filter;
    FBSDKShareLinkContent *content;
    FBSDKShareButton *shareButton;
    NSString *playerName;
    int playerScore;
}

-(IBAction)back:(id)sender;
-(IBAction)share:(id)sender;


@end
