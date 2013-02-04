//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Vladislav Brylinskiy on 04.02.13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *QuestionBuilderErrorDomain;

enum {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError
};

@class Question;

@interface QuestionBuilder : NSObject

@property (strong) Question *questionToFill;
@property (copy) NSString *JSON;

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error;
- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation;

@end
