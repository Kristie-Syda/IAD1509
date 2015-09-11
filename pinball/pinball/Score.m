//
//  Score.m
//  pinball
//
//  Created by Kristie Syda on 8/14/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Score.h"

@implementation Score
@synthesize currentScore,ball,totalScore,pinkCount,currentLevel;

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
}

@end
