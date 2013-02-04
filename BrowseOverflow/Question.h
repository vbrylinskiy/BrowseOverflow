//
//  Question.h
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;

@interface Question : NSObject
{
    NSMutableSet *answerSet;
}

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, copy) NSString *title;
@property (readonly) NSArray *answers;

- (void)addAnswer: (Answer *)answer;

@end
