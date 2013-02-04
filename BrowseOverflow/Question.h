//
//  Question.h
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;
@class Person;

@interface Question : NSObject
{
    NSMutableSet *answerSet;
}

@property (nonatomic, readwrite) NSInteger questionID;
@property (copy) NSString *body;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, copy) NSString *title;
@property (readonly) NSArray *answers;
@property (nonatomic, strong) Person *asker;

- (void)addAnswer: (Answer *)answer;

@end
