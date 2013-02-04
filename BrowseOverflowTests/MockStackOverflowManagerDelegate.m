//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"
#import "Question.h"

@implementation MockStackOverflowManagerDelegate

@synthesize fetchError;
@synthesize receivedQuestions;
@synthesize bodyQuestion;
@synthesize successQuestion;

- (void)fetchingQuestionsFailedWithError: (NSError *)error
{
    self.fetchError = error;
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveQuestions: (NSArray *)questions
{
    self.receivedQuestions = questions;
}

- (void)bodyReceivedForQuestion:(Question *)question {
    self.bodyQuestion = question;
}

- (void)retrievingAnswersFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)answersReceivedForQuestion:(Question *)question {
    self.successQuestion = question;
}


@end
