//
//  UserBuilder.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "UserBuilder.h"
#import "Person.h"

@implementation UserBuilder

+ (Person *) personFromDictionary: (NSDictionary *) ownerValues  {
    NSString *name = [ownerValues objectForKey: @"display_name"];
    NSString *avatarURL = [NSString stringWithFormat: @"http://www.gravatar.com/avatar/%@", [ownerValues objectForKey: @"email_hash"]];
    Person *owner = [[Person alloc] initWithName:name avatarLocation:avatarURL];
    return owner;
}

@end
