//
//  TableMaker.h
//  pinball
//
//  Created by Kristie Syda on 8/24/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface TableMaker : SKNode


@property(nonatomic,assign)SKSpriteNode *plunger;
@property(nonatomic,assign)SKSpriteNode *LFlipper;
@property(nonatomic,assign)SKSpriteNode *RFlipper;


-(SKNode *)createTable;
- (BOOL) collision:(SKNode *)ball;

@end
