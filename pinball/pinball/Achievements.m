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
                    data3 = data[@"ach3"];
                    data4 = data[@"ach4"];
                    data5 = data[@"ach5"];
                }
        
                AchieveData *ach1 = [[AchieveData alloc]init];
                ach1.title = @"Not even one";
                ach1.details = @"Die without hitting one brick";
                ach1.unlocked = data1;
                
                AchieveData *ach2 = [[AchieveData alloc]init];
                ach2.title = @"First Kilo";
                ach2.details = @"Get your first score of 1,000";
                ach2.unlocked = data2;
                
                AchieveData *ach3 = [[AchieveData alloc]init];
                ach3.title = @"3g's on board";
                ach3.details = @"Score 3,000 with one ball";
                ach3.unlocked = data3;
                
                AchieveData *ach4 = [[AchieveData alloc]init];
                ach4.title = @"6g's on board";
                ach4.details = @"Score 6,000 with same ball";
                ach4.unlocked = data4;
                
                AchieveData *ach5 = [[AchieveData alloc]init];
                ach5.title = @"Halfway there";
                ach5.details = @"Beat 5 levels";
                ach5.unlocked = data5;

                dataArray = [[NSMutableArray alloc]initWithObjects:ach1,ach2,ach3,ach4,ach5,nil];
            }
            [myTable reloadData];
        }];
        
    } else if(!current) {
        //guest user - device achievements
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *a1 = [NSNumber numberWithBool:[defaults boolForKey:@"ach1"]];
        NSNumber *a2 = [NSNumber numberWithBool:[defaults boolForKey:@"ach2"]];
        NSNumber *a3 = [NSNumber numberWithBool:[defaults boolForKey:@"ach3"]];
        NSNumber *a4 = [NSNumber numberWithBool:[defaults boolForKey:@"ach4"]];
        NSNumber *a5 = [NSNumber numberWithBool:[defaults boolForKey:@"ach5"]];
        
        AchieveData *ach1 = [[AchieveData alloc]init];
        ach1.title = @"Not even one";
        ach1.details = @"Die without hitting one brick";
        ach1.unlocked = a1;
        
        AchieveData *ach2 = [[AchieveData alloc]init];
        ach2.title = @"First Kilo";
        ach2.details = @"Get your first score of 1,000";
        ach2.unlocked = a2;
        
        AchieveData *ach3 = [[AchieveData alloc]init];
        ach3.title = @"3g's on board";
        ach3.details = @"Score 3,000 with one ball";
        ach3.unlocked = a3;
        
        AchieveData *ach4 = [[AchieveData alloc]init];
        ach4.title = @"6g's on board";
        ach4.details = @"Score 6,000 with same ball";
        ach4.unlocked = a4;
        
        AchieveData *ach5 = [[AchieveData alloc]init];
        ach5.title = @"Halfway there";
        ach5.details = @"Beat 5 levels";
        ach5.unlocked = a5;
        
        dataArray = [[NSMutableArray alloc]initWithObjects:ach1,ach2,ach3,ach4,ach5,nil];
        [myTable reloadData];
    }
}

#pragma mark - TableView methods

- (CustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if(cell != nil)
    {
        //fill in data with custom objects
        AchieveData *currentData = [dataArray objectAtIndex:indexPath.row];
        [cell initWith:currentData.title unlocked:currentData.unlocked details:currentData.details];
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
