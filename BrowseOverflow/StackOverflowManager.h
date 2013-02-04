//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
#import "StackOverflowCommunicator.h"

@class Topic;
@class QuestionBuilder;
@class Question;
@class AnswerBuilder;

extern NSString *StackOverflowManagerSearchFailedError;
extern NSString *StackOverflowManagerDownloadQuestionBodyError;
extern NSString *StackOverflowManagerDownloadQuestionAnswersError;

enum {
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerDownloadQuestionBodyErrorCode,
    StackOverflowManagerErrorAnswerFetchCode
};

@interface StackOverflowManager : NSObject

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;
@property (strong) Question *questionNeedingBody;
@property (strong) AnswerBuilder *answerBuilder;
@property (strong) Question *questionToFill;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)fetchBodyForQuestion:(Question *)question;
- (void)fetchAnswersForQuestion: (Question *)question;

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)fetchingAnswersFailedWithError:(NSError *)error;

- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;
- (void)receivedAnswerListJSON:(NSString *)objectNotation;
@end
