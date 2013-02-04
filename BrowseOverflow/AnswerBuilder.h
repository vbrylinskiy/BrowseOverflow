//
//  AnswerBuilder.h
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface AnswerBuilder : NSObject {
    
}

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)error;

@end

extern NSString *AnswerBuilderErrorDomain;

enum {
    AnswerBuilderErrorInvalidJSONError,
    AnswerBuilderErrorMissingDataError,
};
