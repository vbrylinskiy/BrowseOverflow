//
//  Person.h
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, readwrite) NSString *name;
@property (nonatomic, readwrite) NSURL *avatarURL;

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location;

@end
