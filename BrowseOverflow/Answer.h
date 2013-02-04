//
//  Answer.h
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

@interface Answer : NSObject

@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite, getter=isAccepted) BOOL accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer;

@end
