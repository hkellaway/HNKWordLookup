//
//  NSDate+DEMOAdditions.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/7/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "NSDate+DEMOAdditions.h"
#import "NSDate+HNKAdditions.h"

@implementation NSDate (DEMOAdditions)

#pragma mark - Instance methods

- (BOOL)demo_isToday
{
  NSDate *normalizedToday =
      [[NSDate date] hnk_setToMidnightWithServerDateFormat];
  NSDate *normalizedSelf = [self hnk_setToMidnightWithServerDateFormat];

  return ([normalizedSelf isEqualToDate:normalizedToday]);
}

@end
