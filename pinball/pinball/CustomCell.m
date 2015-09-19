//
//  CustomCell.m
//  pinball
//
//  Created by Kristie Syda on 9/17/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//custom init method for tableview
-(void)initCell:(NSString *)name score:(NSNumber *)score rank:(int)rank {

    NSString *scoreString = [score stringValue];
    NSString *rankString = [NSString stringWithFormat:@"%d",rank];
    
    username.text = name;
    scoreLabel.text = scoreString;
    rankLabel.text = rankString;
}

@end
