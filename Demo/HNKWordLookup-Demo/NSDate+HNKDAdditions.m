//
//  NSDate+HNKDAdditions.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/7/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "NSDate+HNKDAdditions.h"

@implementation NSDate (HNKDAdditions)

#pragma mark - Instance methods

- (BOOL)isToday
{
  NSDate *currentCalendarToday =
      [self currentCalendarVersionOfDate:[NSDate date]];
  NSDate *currentCalendarSelf = [self currentCalendarVersionOfDate:self];

  if ([currentCalendarToday isEqualToDate:currentCalendarSelf]) {
    return YES;
  }

  return NO;
}

#pragma mark - Helpers

- (NSDate *)currentCalendarVersionOfDate:(NSDate *)date
{
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components =
      [calendar components:(NSEraCalendarUnit | NSYearCalendarUnit |
                            NSMonthCalendarUnit | NSDayCalendarUnit)
                  fromDate:date];

  return [calendar dateFromComponents:components];
}

@end
