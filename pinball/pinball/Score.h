//
//  Score.h
//  pinball
//
//  Created by Kristie Syda on 8/14/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property (nonatomic,assign) int currentScore;
@property (nonatomic,assign) int totalScore;
@property (nonatomic, assign) int ball;
@property(nonatomic,assign)int pinkCount;
@property(nonatomic,assign)int brickHit;
@property(nonatomic,assign)int currentLevel;
@property(nonatomic,assign)int levelStreak;


+ (instancetype)shared;

-(void)add:(int)score;

-(void)reset;

@end
