//
//  NSDate+HNKAdditions.h
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/20/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HNKAdditions)

/**
 *  Returns an Date object given a string representation
 *
 *  @param dateString String representing a date
 *
 *  @return Date object
 */
+ (NSDate *)hnk_dateFromString:(NSString *)dateString;

/**
 *  Returns a string representation of a Date object
 *
 *  @param date Date object
 *
 *  @return String representation of a date
 */
+ (NSString *)hnk_stringFromDate:(NSDate *)date;

/**
 *  Returns a string in the YYYY-MM-DD format given year, month, and date numbers
 *
 *  @param year  Year
 *  @param month Month
 *  @param day   Day
 *
 *  @return String in YYYY-MM-DD format
 */
+ (NSString *)hnk_stringFromDateWithYear:(int)year month:(int)month day:(int)day;

@end
