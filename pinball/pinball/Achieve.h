//
//  Achieve.h
//  pinball
//
//  Created by Kristie Syda on 9/21/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achieve : NSObject{
    NSNumber *achNum;
    NSString *playerId;
}

+ (instancetype)shared;

-(void)saveAch:(NSString *)name;

@end
