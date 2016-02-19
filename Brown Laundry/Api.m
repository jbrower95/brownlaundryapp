//
//  Api.m
//  Brown Laundry
//
//  Created by Justin Brower on 2/19/16.
//  Copyright © 2016 Big Sweet Software Projects. All rights reserved.
//

#import "Api.h"

@implementation Api

static const NSString *kBrownApiKey = @"9a7b2d01-06c8-4d18-9c1f-cf7b2eb8353a";

+ (void)getAllRoomsWithBlock:(void (^)(NSArray *rooms, NSError *error))completion {
    NSString *urlContents = [NSString stringWithFormat:@"https://api.students.brown.edu/laundry/rooms?client_id=%@", kBrownApiKey];
    NSURL *url = [NSURL URLWithString:urlContents];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            return completion(nil, error);
        }
        
        NSError *e = nil;
        
        NSDictionary *contents = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
        
        if (e != nil) {
            return completion(nil, e);
        }
        
        NSArray *rooms = contents[@"results"];
        completion(rooms, nil);
    }] resume];
}

+ (void)getLaundryRoomStatusForRoom:(NSString *)roomId withBlock:(void (^)(NSArray *rooms, NSError *error))completion {
    NSString *urlContents = [NSString stringWithFormat:@"https://api.students.brown.edu/laundry/rooms/%@/machines?client_id=%@&get_status=true", roomId, kBrownApiKey];
    
    NSURL *url = [NSURL URLWithString:urlContents];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            return completion(nil, error);
        }
        
        NSError *e = nil;
        
        NSDictionary *contents = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
        
        if (e != nil) {
            return completion(nil, e);
        }
        
        NSArray *rooms = contents[@"results"];
        completion(rooms, nil);
    }] resume];
}

@end
