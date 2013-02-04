//
//  MockStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator

- (BOOL)wasAskedToFetchQuestions;
- (BOOL)wasAskedToFetchBody;
- (NSInteger)askedForAnswersToQuestionID;

@end
