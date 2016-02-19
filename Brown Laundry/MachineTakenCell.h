//
//  MachineTakenCell.h
//  Brown Laundry
//
//  Created by Justin Brower on 2/19/16.
//  Copyright © 2016 Big Sweet Software Projects. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MachineTakenCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *remainingMinutes;
@property (nonatomic, retain) IBOutlet UIImageView *machinePicture;

- (void)applyMachine:(NSDictionary *)machine;
@end
