//
//  Question.m
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "Question.h"
#import "Answer.h"

@implementation Question

@synthesize date;
@synthesize score;
@synthesize body;
@synthesize title;
@synthesize asker;
@synthesize questionID;

- (id)init
{
    if ((self = [super init]))
    {
        answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer
{
    [answerSet addObject: answer];
}

- (NSArray *)answers
{
    return [[answerSet allObjects] sortedArrayUsingSelector: @selector(compare:)];
}

@end
