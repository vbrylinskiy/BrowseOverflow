//
//  Answer.m
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import "Answer.h"

@implementation Answer

@synthesize person;
@synthesize score;
@synthesize text;
@synthesize accepted;

- (NSComparisonResult)compare:(Answer *)otherAnswer
{
    if (accepted && !(otherAnswer.accepted))
    {
        return NSOrderedAscending;
    }
    else if (!accepted && otherAnswer.accepted)
    {
        return NSOrderedDescending;
    }
    
    if (score > otherAnswer.score)
    {
        return NSOrderedAscending;
    }
    else if (score < otherAnswer.score)
    {
        return NSOrderedDescending;
    }
    else
    {
        
        return NSOrderedSame;
    }
}

@end
