//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "QuestionTests.h"
#import "Question.h"

@implementation QuestionTests
{
    Question *question;
}

- (void)setUp {
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
}


- (void)testQuestionHasADate {
    NSDate *testDate = [NSDate distantPast];
    question.date = testDate;
    STAssertEqualObjects(question.date, testDate, @"Question needs to provide its date");
}

- (void)testQuestionsKeepScore
{
    STAssertEquals(question.score, 42,@"Questions need a numeric score");
}

- (void)testQuestionHasATitle {
    STAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title");
}


- (void)tearDown
{
    question = nil;
}


@end
