//
//  Achievements.h
//  pinball
//
//  Created by Kristie Syda on 9/20/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Achievements : UIViewController
{
    IBOutlet UITableView *myTable;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *starImg;
    IBOutlet UILabel *count;
    
    NSMutableArray *dataArray;
    NSNumber *data1;
    NSNumber *data2;
    NSNumber *data3;
    NSNumber *data4;
    NSNumber *data5;
    NSNumber *data6;
    NSNumber *data7;
    NSNumber *data8;
    NSNumber *data9;
    NSNumber *data10;
}

@property(nonatomic,assign)int achieveCount;
-(IBAction)back:(id)sender;

@end
