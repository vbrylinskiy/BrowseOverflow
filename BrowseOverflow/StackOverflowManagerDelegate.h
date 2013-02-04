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

- (void)didReceiveQuestions:(NSArray *)questions;
- (void)fetchingQuestionsFailedWithError:(NSError *)error;

- (void)bodyReceivedForQuestion:(Question *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;

- (void)answersReceivedForQuestion:(Question *)question;
- (void)retrievingAnswersFailedWithError:(NSError *)error;

@end
