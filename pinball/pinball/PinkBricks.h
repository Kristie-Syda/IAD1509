//
//  PinkBricks.h
//  pinball
//
//  Created by Kristie Syda on 8/25/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "TableMaker.h"


@interface PinkBricks : TableMaker
{
    SKAction *brick;
    SKAction *explosion;
}

- (BOOL) collision:(SKNode *)ball;
@end
