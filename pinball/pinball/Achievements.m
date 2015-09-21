//
//  Achievements.m
//  pinball
//
//  Created by Kristie Syda on 9/20/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Achievements.h"

@interface Achievements ()

@end

@implementation Achievements

#pragma mark - UIVewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView methods

- (UITableView *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}



#pragma mark - IBActions

-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
