//
//  Question.h
//  BrowseOverflow
//
//  Created by Brylinskiy Vladislav on 2/4/13.
//  Copyright (c) 2013 Brylinskiy Vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, readwrite) NSDate *date;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *title;

@end
