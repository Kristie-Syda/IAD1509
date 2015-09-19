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

#pragma mark - UIVewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //method call everytime switch changes
    [filter addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
    
    //if user grab player data and add share button to view
    PFUser *current = [PFUser currentUser];
    if(current){
        [self getPlayerData];
        [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        //no share button for guest or player data to grab
    }
    //initial loading of the data
    [self grabData];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Share button methods

//required share button methods
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    
}
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    
}
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    
}

#pragma mark - grabbing data methods

//grabs the correct data and loads into table
-(void)grabData {
    
    //initialize array
    dataArray = [[NSMutableArray alloc]init];
    
    if (filter.on) {
        
        //get all data from highscore database
        PFQuery *query = [PFQuery queryWithClassName:@"HighScore"];
        [query orderByDescending:@"Score"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *allPlayers, NSError *error) {
        
            int i = 0;
            
                //loop through data and create custom object
                for (PFObject *player in allPlayers) {
                
                    LBData *data = [[LBData alloc]init];
                    data.username = player[@"Username"];
                    data.score = player[@"Score"];
                    data.level = player[@"Level"];
                    data.playerId = player[@"playerId"];
                    data.userLocation = player[@"Location"];
                    data.rank = ++i;
                    
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
                [query whereKey:@"Location" nearGeoPoint:currentLocation withinMiles:50];
                 NSArray *allLocations = [query findObjects];
                
                int i = 0;
                
                //loop through data and create custom object
                for (PFObject *player in allLocations) {
                        
                    LBData *data = [[LBData alloc]init];
                    data.username = player[@"Username"];
                    data.score = player[@"Score"];
                    data.level = player[@"Level"];
                    data.playerId = player[@"playerId"];
                    data.userLocation = player[@"Location"];
                    data.rank = ++i;
                        
                    //add to array
                    [dataArray addObject:data];
                }
                //reload data while in this method to finish loading
                [myTable reloadData];
            }];
    }
    
}
-(void)getPlayerData{
    
    PFUser *currentUser = [PFUser currentUser];
    
    //Find the player id that matches current user object id
    PFQuery *query = [PFQuery queryWithClassName:@"HighScore"];
    [query whereKey:@"playerId" equalTo:[currentUser objectId]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *players, NSError *error) {
        if (!error) {
            NSString *playerId;
            
            //grab the player's objectId
            for (PFObject *data in players) {
                
                //store id
                playerId = [data objectId];
                playerScore = [data[@"Score"] intValue];
            }
            
            PFQuery *data = [PFQuery queryWithClassName:@"HighScore"];
            [data getObjectInBackgroundWithId:playerId block:^(PFObject *player, NSError *error) {
                
                playerScore = [player[@"Score"] intValue];
                playerName = player[@"Username"];
                
                content = [[FBSDKShareLinkContent alloc] init];
                content.contentURL = [NSURL
                                      URLWithString:@"https://developers.facebook.com/apps/988202167888514/"];
                content.contentTitle = @"FlipBall";
                content.contentDescription = [NSString stringWithFormat:@"%@ has a score of %d on FlipBall!",playerName,playerScore];
                
                shareButton = [[FBSDKShareButton alloc] initWithFrame:CGRectMake(30, 110, 110, 30)];
                shareButton.shareContent = content;
                [self.view addSubview:shareButton];
                
            }];

        }
    }];
    
}

#pragma mark - TableView methods

- (CustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell != nil)
    {
        //fill in data with custom objects
        LBData *currentData = [dataArray objectAtIndex:indexPath.row];
        [cell initCell:currentData.username score:currentData.score rank:currentData.rank];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [dataArray count];
}

#pragma mark - IBActions

//switch method action
-(IBAction)switched:(id)sender {
    
    if ([sender isOn]) {
        [self grabData];
    } else {
        [self grabData];
    }
}
//share button action
-(IBAction)share:(id)sender {
    [FBSDKShareDialog showFromViewController:self.view.window.rootViewController withContent:content delegate:self];
}
//back button
-(IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
