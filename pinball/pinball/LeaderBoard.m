//
//  LeaderBoard.m
//  pinball
//
//  Created by Kristie Syda on 9/17/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "LeaderBoard.h"
#import <Parse/Parse.h>
#import "LBData.h"
#import "CustomCell.h"


@interface LeaderBoard ()

@end

@implementation LeaderBoard

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //method call everytime switch changes
    [filter addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
    
    //initial loading of the data
    [self grabData];
}

//switch method
-(void)switched:(id)sender {
    
    if ([sender isOn]) {
        [self grabData];
        
    } else {
        
        [self grabData];
        
    }
}

//grabs the correct data and loads into table
-(void)grabData {
    
    //initialize array
    dataArray = [[NSMutableArray alloc]init];
    
    if (filter.on) {
        
        //get all data from highscore database
        PFQuery *query = [PFQuery queryWithClassName:@"HighScore"];
        [query orderByDescending:@"Score"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *allPlayers, NSError *error) {
            
                //loop through data and create custom object
                for (PFObject *player in allPlayers) {
                
                    LBData *data = [[LBData alloc]init];
                    data.username = player[@"Username"];
                    data.score = player[@"Score"];
                    data.level = player[@"Level"];
                    data.playerId = player[@"playerId"];
                    data.userLocation = player[@"Location"];
                
                    //add to array
                    [dataArray addObject:data];
                }
                //reload data while in this method to finish loading
                [myTable reloadData];
        }];
        
    } else if(filter.on == FALSE) {
        
        //get all data from highscore database
        PFQuery *query = [PFQuery queryWithClassName:@"HighScore"];
        [query orderByDescending:@"Score"];
                
            [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *point, NSError *err){
                    
                PFGeoPoint *currentLocation = point;
                [query whereKey:@"Location" nearGeoPoint:currentLocation withinMiles:10];
                 NSArray *allLocations = [query findObjects];
                    
                //loop through data and create custom object
                for (PFObject *player in allLocations) {
                        
                    LBData *data = [[LBData alloc]init];
                    data.username = player[@"Username"];
                    data.score = player[@"Score"];
                    data.level = player[@"Level"];
                    data.playerId = player[@"playerId"];
                    data.userLocation = player[@"Location"];
                        
                    //add to array
                    [dataArray addObject:data];
                }
                //reload data while in this method to finish loading
                [myTable reloadData];
                    
            }];
    }
    
}


- (CustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell != nil)
    {
        //fill in data with custom objects
        LBData *currentData = [dataArray objectAtIndex:indexPath.row];
        [cell initCell:currentData.username score:currentData.score];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArray count];
}

//back button
-(IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
