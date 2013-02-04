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

extern NSString *StackOverflowManagerSearchFailedError;
extern NSString *StackOverflowManagerDownloadQuestionBodyError;
enum {
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerDownloadQuestionBodyErrorCode
};

@interface StackOverflowManager : NSObject

@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property (strong) StackOverflowCommunicator *communicator;
@property (strong) QuestionBuilder *questionBuilder;
@property (strong) Question *questionNeedingBody;

- (void)fetchQuestionsOnTopic:(Topic *)topic;
- (void)fetchBodyForQuestion:(Question *)question;

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;

- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

@end
