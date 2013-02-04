//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;
@class Question;
@protocol StackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)fetchingQuestionBodyFailedWithError: (NSError *)error;
- (void)didReceiveQuestions:(NSArray *)questions;
- (void)bodyReceivedForQuestion: (Question *)question;

@end
