//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "QuestionBuilder.h"
#import "Question.h"
#import "UserBuilder.h"

NSString *QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";

@implementation QuestionBuilder

@synthesize questionToFill;
@synthesize JSON;


- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    NSParameterAssert(objectNotation != nil);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    
    NSError *localError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation
                                                    options:0
                                                      error:&localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderInvalidJSONError userInfo:nil];
        }
        return nil;
    }
    
    NSArray *questions = [parsedObject objectForKey: @"questions"];
    
    if (questions == nil)
    {
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code: QuestionBuilderMissingDataError userInfo:nil];
        }
        return nil;
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity: [questions count]];
    for (NSDictionary *parsedQuestion in questions) {
        Question *thisQuestion = [[Question alloc] init];
        thisQuestion.questionID = [[parsedQuestion objectForKey: @"question_id"] integerValue];
        thisQuestion.date = [NSDate dateWithTimeIntervalSince1970: [[parsedQuestion objectForKey: @"creation_date"] doubleValue]];
        thisQuestion.title = [parsedQuestion objectForKey: @"title"];
        thisQuestion.score = [[parsedQuestion objectForKey: @"score"] integerValue];
        NSDictionary *ownerValues = [parsedQuestion objectForKey: @"owner"];
        thisQuestion.asker = [UserBuilder personFromDictionary: ownerValues];
        [results addObject:thisQuestion];
    }
    return [results copy];
}

- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation
{
    NSParameterAssert(objectNotation != nil);
    NSParameterAssert(question != nil);
    
    self.questionToFill = question;
    self.JSON = objectNotation;

    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    
    NSError *localError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation
                                                    options:0
                                                      error:&localError];
    
    if (![jsonObject isKindOfClass: [NSDictionary class]]) {
        return;
    }
    
    NSDictionary *parsedObject = (id)jsonObject;

    NSString *questionBody = [[[parsedObject objectForKey: @"questions"] lastObject] objectForKey: @"body"];
    if (questionBody) {
        question.body = questionBody;
    }
}


@end
