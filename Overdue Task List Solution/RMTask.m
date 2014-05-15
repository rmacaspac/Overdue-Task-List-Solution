//
//  RMTask.m
//  Overdue Task List Solution
//
//  Created by Ryan Macaspac on 5/14/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMTask.h"

@implementation RMTask

- (id)init
{
    self = [self initWithData:nil];
    return self;
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    self.title = data[TASK_TITLE];
    self.description = data[TASK_DESCRIPTION];
    self.date = data[TASK_DATE];
    self.completion = [data[TASK_COMPLETION] boolValue];
    
    return self;
}

@end
