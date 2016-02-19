//
//  ViewController.m
//  Brown Laundry
//
//  Created by Justin Brower on 2/19/16.
//  Copyright © 2016 Big Sweet Software Projects. All rights reserved.
//

#import "ViewController.h"
#import "Api.h"
#import "MachineTakenCell.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tableView, roomLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSDictionary *room = [[NSUserDefaults standardUserDefaults] objectForKey:@"laundryRoom"];
    
    if (room == nil) {
        return [self performSegueWithIdentifier:@"ChooseRoomSegue" sender:nil];
    }
    
    [self.roomLabel setText:room[@"name"]];
    [self reload];
}

- (void)reload {
    NSDictionary *room = [[NSUserDefaults standardUserDefaults] objectForKey:@"laundryRoom"];
    [Api getLaundryRoomStatusForRoom:room[@"id"] withBlock:^(NSArray *roomsParsed, NSError *error) {
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            });
        } else {
            self.rooms = [roomsParsed filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                NSDictionary *room = (NSDictionary *)evaluatedObject;
                return ([room[@"type"] isEqualToString:@"dblDry"] || [room[@"type"] isEqualToString:@"dry"] || [room[@"type"] isEqualToString:@"washFL"]);
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

- (IBAction)chooseRoom:(id)sender {
    [self performSegueWithIdentifier:@"ChooseRoomSegue" sender:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *dryerString = @"dblDry";
    NSString *dryerStringTwo = @"dry";
    
    
    NSString *washerString = @"washFL";
    
    NSDictionary *room = self.rooms[indexPath.row];
    
    BOOL available = [room[@"avail"] boolValue];
    int timeRemaining = [room[@"time_remaining"] intValue];
    
    UITableViewCell *cell;
    
    if ([room[@"type"] isEqualToString:dryerString] || [room[@"type"] isEqualToString:dryerStringTwo]) {
        // Dryer cell.
        if (available) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DryerFreeCell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DryerFreeCell"];
            }
            return cell;
        } else {
            MachineTakenCell *takenCell = [tableView dequeueReusableCellWithIdentifier:@"MachineTakenCell"];
            if (takenCell == nil) {
                takenCell = [[MachineTakenCell alloc] init];
            }
            [takenCell applyMachine:room];
            return takenCell;
        }
        
    } else if ([room[@"type"] isEqualToString:washerString]) {
        // Washer cell.
        if (available) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"WasherFreeCell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WasherFreeCell"];
            }
            return cell;
        } else {
            MachineTakenCell *takenCell = [tableView dequeueReusableCellWithIdentifier:@"MachineTakenCell"];
            if (takenCell == nil) {
                takenCell = [[MachineTakenCell alloc] init];
            }
            [takenCell applyMachine:room];
            return takenCell;
        }
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rooms count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
