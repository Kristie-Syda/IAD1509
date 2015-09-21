//
//  Achieve.m
//  pinball
//
//  Created by Kristie Syda on 9/21/15.
//  Copyright (c) 2015 ___ksyda___. All rights reserved.
//

#import "Achieve.h"
#import <Parse/Parse.h>

@implementation Achieve


+(instancetype)shared {

static dispatch_once_t pred = 0;
static Achieve *shared = nil;
dispatch_once( &pred, ^{
    shared = [[super alloc] init];
});
    
return shared;
    
}


-(id)init {
    
    if (self = [super init]) {
        
        
        
    }
    
    return self;
}

-(void)saveAch:(NSString *)name {
    
    PFUser *current = [PFUser currentUser];
    
    if(current) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Achievements"];
        [query whereKey:@"PlayerId" equalTo:[current objectId]];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *achievements, NSError *error) {
        
            if (!error) {
                
                //grab the player's objectId
                for (PFObject *title in achievements) {
                    
                    achNum = title[name];
                    playerId = [title objectId];
                }
                
                PFQuery *data = [PFQuery queryWithClassName:@"Achievements"];
                [data getObjectInBackgroundWithId:playerId block:^(PFObject *ach, NSError *error) {
                    
                    //if achNum is false
                   if ([achNum isEqualToNumber:[NSNumber numberWithInt:0]]) {
                        //turn achievement to true
                        ach[name] = [NSNumber numberWithBool:true];
                
                        //shows a pop up alert thats lets user know they earned achievement
                        UIAlertView *toastMsg = [[UIAlertView alloc]initWithTitle:nil message:@"Achievement Earned" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                        toastMsg.backgroundColor = [UIColor blackColor];
                        [toastMsg show];
                        int duration = 1;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(),
                            ^{
                                [toastMsg dismissWithClickedButtonIndex:0 animated:YES];
                            });
                
                    } else {
                        //do nothing because achievement already true
                    }
                     [ach saveInBackground];
                }];

            } else {
                //error
            }

        }];

    } else {
        //guest user
    }

}

@end
