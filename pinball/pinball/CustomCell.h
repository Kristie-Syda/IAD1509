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
    IBOutlet UILabel *username;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *rankLabel;
}

//custom method to populate custom cell
-(void)initCell:(NSString *)name score:(NSNumber *)score rank:(int)rank;

@end
