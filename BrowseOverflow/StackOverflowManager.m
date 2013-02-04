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

NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";
NSString *StackOverflowManagerDownloadQuestionBodyError = @"StackOverflowManagerDownloadQuestionBodyError";

@implementation StackOverflowManager

@synthesize delegate;
@synthesize communicator;
@synthesize questionBuilder;
@synthesize questionNeedingBody;

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



@end
