//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

@synthesize JSON;
@synthesize arrayToReturn;
@synthesize errorToSet;

- (NSArray *)questionsFromJSON: (NSString *)objectNotation
                         error: (NSError **)error
{
    self.JSON = objectNotation;
    *error = errorToSet;
    return arrayToReturn;;
}

@end
