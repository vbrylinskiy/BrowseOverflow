//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"

@implementation MockStackOverflowManagerDelegate

@synthesize fetchError;
@synthesize receivedQuestions;

- (void)fetchingQuestionsFailedWithError: (NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveQuestions: (NSArray *)questions
{
    self.receivedQuestions = questions;
}

@end
