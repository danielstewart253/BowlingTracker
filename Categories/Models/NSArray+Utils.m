//
//  NSArray+Utils.m
//  Bowlr
//
//  Created by Daniel Stewart on 5/4/17.
//  Copyright © 2017 Daniel Stewart. All rights reserved.
//

#import "NSArray+Utils.h"

@implementation NSArray (Utils)

// Returns the index for where a String object would be placed in alphabetical order
- (NSUInteger)indexForAscendingStrings:(NSString *)text
{
    for(NSUInteger i = 0; i < [self count]; i++)
    {
        if([text localizedCaseInsensitiveCompare: [self objectAtIndex: i]] == NSOrderedAscending)
        {
            return i;
        }
    }
    
    return [self count];
}

- (BOOL)isEmpty
{
    return ([self count] == 0);
}

@end
