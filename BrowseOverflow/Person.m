//
//  Person.m
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize name;
@synthesize avatarURL;

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location
{
    if (self = [super init])
    {
        name = [aName copy];
        avatarURL = [[NSURL alloc] initWithString: location];
    }
    return self;
}

@end
