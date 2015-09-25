//
//  DetailViewController.h
//  pinball
//
//  Created by Kristie Syda on 9/22/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBData.h"

@interface DetailViewController : UIViewController
{
    IBOutlet UILabel *usernameLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UITableView *myTable;
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
    NSString *player;
}
@property(nonatomic,strong)LBData *data;
@property(nonatomic,assign)int achieveCount;
@end
