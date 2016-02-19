//
//  Api.h
//  Brown Laundry
//
//  Created by Justin Brower on 2/19/16.
//  Copyright © 2016 Big Sweet Software Projects. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Api : NSObject

+ (void)getAllRoomsWithBlock:(void (^)(NSArray *rooms, NSError *error))block;

+ (void)getLaundryRoomStatusForRoom:(NSString *)roomId withBlock:(void (^)(NSArray *rooms, NSError *error))block;

@end
