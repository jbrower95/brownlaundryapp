//
//  ViewController.h
//  Brown Laundry
//
//  Created by Justin Brower on 2/19/16.
//  Copyright © 2016 Big Sweet Software Projects. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *rooms;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UILabel *roomLabel;

- (IBAction)chooseRoom:(id)sender;

@end

