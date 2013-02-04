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
}

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    wasAskedToFetchQuestions = YES;
}

- (void)downloadInformationForQuestionWithID:(NSInteger)questionID
{
    wasAskedToFetchBody = YES;
}

- (BOOL)wasAskedToFetchQuestions
{
    return wasAskedToFetchQuestions;
}

- (BOOL)wasAskedToFetchBody
{
    return wasAskedToFetchBody;
}


@end
