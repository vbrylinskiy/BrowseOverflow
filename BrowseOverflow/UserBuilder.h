//
//  UserBuilder.h
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface UserBuilder : NSObject

+ (Person *) personFromDictionary: (NSDictionary *) ownerValues;

@end
