//
//  LeaderBoard.h
//  pinball
//
//  Created by Kristie Syda on 9/17/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>



@interface LeaderBoard : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *myTable;
    NSMutableArray *dataArray;
    IBOutlet UISwitch *filter;
}

-(IBAction)back:(id)sender;

@end
