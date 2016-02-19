//
//  MachineTakenCell.m
//  Brown Laundry
//
//  Created by Justin Brower on 2/19/16.
//  Copyright © 2016 Big Sweet Software Projects. All rights reserved.
//

#import "MachineTakenCell.h"

@implementation MachineTakenCell

- (void)applyMachine:(NSDictionary *)machine {
    
    if (machine != nil) {
        int timeRemaining = [machine[@"time_remaining"] intValue];
        [self.remainingMinutes setText:[NSString stringWithFormat:@"%d", timeRemaining]];
    
        NSString *type = machine[@"type"];
        if ([type isEqualToString:@"dblDry"] || [type isEqualToString:@"dry"]) {
            [self.machinePicture setImage:[UIImage imageNamed:@"dryer-taken"]];
        } else if ([type isEqualToString:@"washFL"]) {
            [self.machinePicture setImage:[UIImage imageNamed:@"washer-taken"]];
        }
    }
    
}

@end
