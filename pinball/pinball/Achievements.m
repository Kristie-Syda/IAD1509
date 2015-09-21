//
//  Achievements.m
//  pinball
//
//  Created by Kristie Syda on 9/20/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Achievements.h"
#import "AchieveData.h"
#import "CustomCell.h"
#import <Parse/Parse.h>

@interface Achievements ()

@end

@implementation Achievements

#pragma mark - UIVewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self grabData];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)grabData{
    
    PFUser *current = [PFUser currentUser];
    if (current) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Achievements"];
        [query whereKey:@"PlayerId" equalTo:[current objectId]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *everything, NSError *error) {
            if (!error) {
                
                //grab the player's objectId
                for (PFObject *data in everything) {
                    
                    data1 = data[@"ach1"];
                    data2 = data[@"ach2"];
                }
        
                AchieveData *ach1 = [[AchieveData alloc]init];
                ach1.title = @"Not even one";
                ach1.details = @"Dieing without hitting one brick";
                ach1.unlocked = data1;
                
                AchieveData *ach2 = [[AchieveData alloc]init];
                ach2.title = @"First Kilo";
                ach2.details = @"Getting your first score of 1,000";
                ach2.unlocked = data2;

                dataArray = [[NSMutableArray alloc]initWithObjects:ach1,ach2,nil];
            }
            [myTable reloadData];

        }];
        
    }
    
    
}

#pragma mark - TableView methods

- (CustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if(cell != nil)
    {
        //fill in data with custom objects
        AchieveData *currentData = [dataArray objectAtIndex:indexPath.row];
        [cell initWith:currentData.title unlocked:currentData.unlocked];
    }    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [dataArray count];
}

#pragma mark - IBActions

-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
