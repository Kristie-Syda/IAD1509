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

-(void)initCell:(NSString *)name score:(NSNumber *)score {
    
    NSString *scoreString = [score stringValue];
    
    username.text = name;
    scoreLabel.text = scoreString;
    
}

@end
