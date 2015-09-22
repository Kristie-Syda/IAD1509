//
//  LBData.h
//  pinball
//
//  Created by Kristie Syda on 9/17/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface LBData : NSObject
@property(nonatomic, strong) NSNumber *score;
@property(nonatomic, assign) NSString *playerId;
@property(nonatomic, assign) NSNumber *level;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) PFGeoPoint *userLocation;
@property(nonatomic, assign) int rank;

@end
