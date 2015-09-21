//
//  CustomCell.h
//  pinball
//
//  Created by Kristie Syda on 9/17/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    //stuff for the leaderboards
    IBOutlet UILabel *username;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *rankLabel;
    
    //stuff for the achievement cells
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *starImg;
    IBOutlet UIView *view;
    NSNumber *select;
}

@property(nonatomic, strong)IBOutlet UIView *cellBack;

//custom methods to populate custom cella - LeaderBoard & Achievements
-(void)initCell:(NSString *)name score:(NSNumber *)score rank:(int)rank;
-(void)initWith:(NSString *)title unlocked:(NSNumber *)number;
@end
