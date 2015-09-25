//
//  Score.m
//  pinball
//
//  Created by Kristie Syda on 8/14/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Score.h"
#import <Parse/Parse.h>
#import "Achieve.h"

@implementation Score
@synthesize currentScore,ball,totalScore,pinkCount,currentLevel,brickHit,levelStreak;

+(instancetype)shared {
    
    static dispatch_once_t pred = 0;
    
    static Score *shared = nil;
    
    dispatch_once( &pred, ^{
        shared = [[super alloc] init];
    });
    return shared;
}

-(id)init {
    
    if (self = [super init]) {
        
        totalScore = 0;
        currentScore = 0;
        ball = 1;
        currentLevel = 1;
        brickHit = 0;
        levelStreak = 0;
        
        NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
        [data setInteger:1 forKey:@"passed"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return self;
}

//store currentscore in totalScore for that round
-(void)add:(int)score {
    totalScore += currentScore;
}

-(void)reset {
    ball = 1;
    totalScore = 0;
    currentScore = 0;
    brickHit = 0;
    levelStreak = 0;
}

@end
