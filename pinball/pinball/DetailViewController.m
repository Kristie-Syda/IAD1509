//
//  DetailViewController.m
//  pinball
//
//  Created by Kristie Syda on 9/22/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "DetailViewController.h"
#import "AchieveData.h"
#import "CustomCell.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - UIVewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNumber *score = self.data.score;
    usernameLabel.text = self.data.username;
    scoreLabel.text = [score stringValue];
 
    [self grabData];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Grabbing data methods

// Grab Data Method
//
// Puts all Users achievement data into custom objects
// and reminds table to reload
//
-(void)grabData{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Achievements"];
    [query whereKey:@"Username" equalTo:self.data.username];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *everything, NSError *error) {
        if (!error) {
            
            //grab the player's objectId
            for (PFObject *objects in everything) {
                data1 = objects[@"ach1"];
                data2 = objects[@"ach2"];
                data3 = objects[@"ach3"];
                data4 = objects[@"ach4"];
                data5 = objects[@"ach5"];
                data6 = objects[@"ach6"];
                data7 = objects[@"ach7"];
                data8 = objects[@"ach8"];
                data9 = objects[@"ach9"];
                data10 = objects[@"ach10"];
            }
            
            AchieveData *ach1 = [[AchieveData alloc]init];
            ach1.title = @"First Kilo";
            ach1.details = @"Get your first score of 1,000";
            ach1.unlocked = data1;
            
            AchieveData *ach2 = [[AchieveData alloc]init];
            ach2.title = @"3g's on board";
            ach2.details = @"Score 3,000 with one ball";
            ach2.unlocked = data2;
            
            AchieveData *ach3 = [[AchieveData alloc]init];
            ach3.title = @"6g's on board";
            ach3.details = @"Score 6,000 with same ball";
            ach3.unlocked = data3;
            
            AchieveData *ach4 = [[AchieveData alloc]init];
            ach4.title = @"10g's on board";
            ach4.details = @"Score 10,000 on score board";
            ach4.unlocked = data4;
            
            AchieveData *ach5 = [[AchieveData alloc]init];
            ach5.title = @"Not even one";
            ach5.details = @"Die without hitting one brick";
            ach5.unlocked = data5;
            
            AchieveData *ach6 = [[AchieveData alloc]init];
            ach6.title = @"Getting Started";
            ach6.details = @"Beat level 1";
            ach6.unlocked = data6;
            
            AchieveData *ach7 = [[AchieveData alloc]init];
            ach7.title = @"Halfway there";
            ach7.details = @"Beat level 5";
            ach7.unlocked = data7;
            
            AchieveData *ach8 = [[AchieveData alloc]init];
            ach8.title = @"Veteran Status";
            ach8.details = @"Beat all 10 levels";
            ach8.unlocked = data8;
            
            AchieveData *ach9 = [[AchieveData alloc]init];
            ach9.title = @"3 in a row";
            ach9.details = @"Beat any 3 levels without a gameover";
            ach9.unlocked = data9;
            
            AchieveData *ach10 = [[AchieveData alloc]init];
            ach10.title = @"The Real MVP";
            ach10.details = @"Beat all 10 levels without a gameover";
            ach10.unlocked = data10;
            
            dataArray = [[NSMutableArray alloc]initWithObjects:ach1,ach2,ach3,ach4,ach5,ach6,ach7,ach8,ach9,ach10,nil];
        }
        [self grabCount];
        [myTable reloadData];
    }];
}

// Grab Count Method
//
// Grabs the count of all completed
// achievements from the user and sets the label
//
-(void)grabCount {
    for (AchieveData *dataCount in dataArray) {
        if ([dataCount.unlocked isEqualToNumber:[NSNumber numberWithInt:1]]) {
            self.achieveCount += 1;
        }
    }
    count.text = [NSString stringWithFormat:@"%i/10",self.achieveCount];
}

#pragma mark - TableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

@end
