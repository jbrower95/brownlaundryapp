//
//  ChooseRoomViewController.m
//  Brown Laundry
//
//  Created by Justin Brower on 2/19/16.
//  Copyright © 2016 Big Sweet Software Projects. All rights reserved.
//

#import "ChooseRoomViewController.h"
#import "Api.h"

@implementation ChooseRoomViewController
@synthesize locations;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locations = [[NSArray alloc] init];
    
    [Api getAllRoomsWithBlock:^(NSArray *rooms, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                self.locations = rooms;
                [self.tableView reloadData];
            }
        });
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationCell"];
    }
    
    NSDictionary *room = self.locations[indexPath.row];
    [[cell textLabel] setText:room[@"name"]];
    
    NSDictionary *laundryRoom = [[NSUserDefaults standardUserDefaults] objectForKey:@"laundryRoom"];
    if (laundryRoom != nil) {
        if ([room[@"id"] isEqualToString:laundryRoom[@"id"]]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *room = self.locations[indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:room forKey:@"laundryRoom"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count];
}

@end
