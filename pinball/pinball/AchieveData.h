//
//  AchieveData.h
//  pinball
//
//  Created by Kristie Syda on 9/20/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AchieveData : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *details;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, assign) NSString *playerId;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, assign) NSNumber *unlocked;
@end
