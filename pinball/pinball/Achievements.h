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
    
    NSMutableArray *dataArray;
}

-(IBAction)back:(id)sender;

@end
