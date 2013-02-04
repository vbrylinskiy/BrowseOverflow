//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator
{
    BOOL wasAskedToFetchQuestions;
    BOOL wasAskedToFetchBody;
    NSInteger questionID;
}

- (id)init {
    if ((self = [super init])) {
        questionID = NSNotFound;
    }
    return self;
}


- (void)searchForQuestionsWithTag:(NSString *)tag
{
    wasAskedToFetchQuestions = YES;
}

- (void)downloadInformationForQuestionWithID:(NSInteger)questionID
{
    wasAskedToFetchBody = YES;
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    questionID = identifier;
}


- (BOOL)wasAskedToFetchQuestions
{
    return wasAskedToFetchQuestions;
}

- (BOOL)wasAskedToFetchBody
{
    return wasAskedToFetchBody;
}

- (NSInteger)askedForAnswersToQuestionID {
    return questionID;
}



@end
