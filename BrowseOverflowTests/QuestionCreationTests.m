//
//  QuestionCreationTests.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "QuestionCreationTests.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "Topic.h"
#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation QuestionCreationTests
{
@private
    StackOverflowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    NSError *underlyingError;
    FakeQuestionBuilder *builder;
    NSArray *questionArray;
}

- (void)setUp
{
    mgr = [[StackOverflowManager alloc] init];
    Question *question = [[Question alloc] init];
    questionArray = [NSArray arrayWithObject:question];
    
    builder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = builder;
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
}

- (void)tearDown
{
    questionArray = nil;
    builder = nil;
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
}

- (void)testNonConformingObjectCannotBeDelegate
{
    STAssertThrows(mgr.delegate = (id <StackOverflowManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate as doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate
{
    STAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testAskingForQuestionsMeansRequestingData
{
    MockStackOverflowCommunicator *communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    STAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data.");
}

- (void)testManagerAcceptsNilAsADelegate
{
    STAssertNoThrow(mgr.delegate = nil, @"It should be acceptable to use nil as an object’s delegate");
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator
{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    STAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError
{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder
{
    builder.errorToSet = underlyingError;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    STAssertEqualObjects(builder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails
{
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    STAssertNotNil([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], @"The delegate should have found out about the error");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotToldAboutErrorWhenQuestionsReceived
{
    builder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    STAssertNil([delegate fetchError], @"No error should be received on success");
}

- (void)testDelegateReceivesTheQuestionsDiscoveredByManager
{
    builder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    STAssertEqualObjects([delegate receivedQuestions], questionArray, @"The manager should have sent its questions to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate {
    builder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    STAssertEqualObjects([delegate receivedQuestions], [NSArray array], @"Returning an empty array is not an error");
}

@end
