//
//  NSDate+DEMOAdditions.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/7/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "NSDate+DEMOAdditions.h"

@implementation NSDate (DEMOAdditions)

#pragma mark - Instance methods

- (BOOL)demo_isToday
{
  NSDate *normalizedToday = [[NSDate date] setToMidnight];
  NSDate *normalizedSelf = [self setToMidnight];

  return ([normalizedSelf isEqualToDate:normalizedToday]);
}

#pragma mark - Helpers

- (NSDate *)setToMidnight
{
  NSCalendar *gregorianCalendar =
      [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSDateComponents *dateComponents =
      [gregorianCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                                     NSDayCalendarUnit | NSEraCalendarUnit)
                           fromDate:self];

  return [gregorianCalendar dateFromComponents:dateComponents];
}

@end
