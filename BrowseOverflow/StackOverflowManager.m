//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "StackOverflowManager.h"
#import "Topic.h"
#import "QuestionBuilder.h"
#import "Question.h"
#import "AnswerBuilder.h"

NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";
NSString *StackOverflowManagerDownloadQuestionBodyError = @"StackOverflowManagerDownloadQuestionBodyError";
NSString *StackOverflowManagerDownloadQuestionAnswersError = @"StackOverflowManagerDownloadQuestionAnswersError";

@implementation StackOverflowManager

@synthesize delegate;
@synthesize communicator;
@synthesize questionBuilder;
@synthesize questionNeedingBody;
@synthesize answerBuilder;
@synthesize questionToFill;

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate
{
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)])
    {
            [[NSException exceptionWithName:NSInvalidArgumentException reason: @"Delegate object does not conform to the delegate protocol" userInfo: nil] raise];
    }
    
    delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic
{
    [communicator searchForQuestionsWithTag:[topic tag]];
}

- (void)fetchBodyForQuestion:(Question *)question
{
    self.questionNeedingBody = question;
    [communicator downloadInformationForQuestionWithID:question.questionID];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON:objectNotation error:&error];
    if (!questions)
    {        
        [self tellDelegateAboutQuestionSearchError:error];
    }
    else
    {
        [delegate didReceiveQuestions:questions];
    }
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation
{
    [questionBuilder fillInDetailsForQuestion:self.questionNeedingBody fromJSON:objectNotation];
    [delegate bodyReceivedForQuestion:self.questionNeedingBody];
    
    self.questionNeedingBody = nil;
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    [self tellDelegateAboutDownloadingOfQuestionBodyError:error];
}

- (void)tellDelegateAboutQuestionSearchError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey: NSUnderlyingErrorKey];
    
    NSError *reportableError = [NSError
                                errorWithDomain:StackOverflowManagerSearchFailedError
                                code: StackOverflowManagerErrorQuestionSearchCode
                                userInfo:errorInfo];
    
    [delegate fetchingQuestionsFailedWithError:reportableError];
}

- (void)tellDelegateAboutDownloadingOfQuestionBodyError:(NSError *)error
{
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    
    NSError *reportableError = [NSError
                                errorWithDomain:StackOverflowManagerDownloadQuestionBodyError
                                code: StackOverflowManagerDownloadQuestionBodyErrorCode
                                userInfo:errorInfo];
    

    [delegate fetchingQuestionBodyFailedWithError:reportableError];
    self.questionNeedingBody = nil;
}


- (void)fetchAnswersForQuestion:(Question *)question {
    self.questionToFill = question;
    [communicator downloadAnswersToQuestionWithID: question.questionID];
}

- (void)fetchingAnswersFailedWithError:(NSError *)error {
    self.questionToFill = nil;
    NSDictionary *userInfo = nil;
    if (error) {
        userInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerDownloadQuestionAnswersError code:StackOverflowManagerErrorAnswerFetchCode userInfo: userInfo];
    [delegate retrievingAnswersFailedWithError: reportableError];
}

- (void)receivedAnswerListJSON: (NSString *)objectNotation {
    NSError *error = nil;
    if ([self.answerBuilder addAnswersToQuestion: self.questionToFill fromJSON: objectNotation error: &error]) {
        [delegate answersReceivedForQuestion: self.questionToFill];
        self.questionToFill = nil;
    }
    else {
        [self fetchingAnswersFailedWithError: error];
    }
}



@end
