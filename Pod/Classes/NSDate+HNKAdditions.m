//
//  NSDate+HNKAdditions.m
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/20/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "NSDate+HNKAdditions.h"

static NSString * const kHNKDateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";

@implementation NSDate (HNKAdditions)

#pragma mark - Class methods

+ (NSDate *)hnk_dateFromString:(NSString *)dateString
{
	return [self.dateFormatter dateFromString:dateString];
}

+ (NSString *)hnk_stringFromDate:(NSDate *)date
{
	return [self.dateFormatter stringFromDate:date];
}

+ (NSString *)hnk_stringFromDateWithYear:(int)year month:(int)month day:(int)day
{
	NSString *yearString = [NSString stringWithFormat:@"%i", year];
	NSString *monthString = [self dateStringForValue:month];
	NSString *dayString = [self dateStringForValue:day];

	return [NSString stringWithFormat:@"%@-%@-%@", yearString, monthString, dayString];
}

# pragma mark - Helpers

+ (NSDateFormatter *)dateFormatter
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = kHNKDateFormat;

	return dateFormatter;
}

+ (NSString *)dateStringForValue:(int)value
{
	NSString *valueString = [NSString stringWithFormat:@"%i", value];

	if([valueString length] == 1) {
		return [NSString stringWithFormat:@"%i%@", 0, valueString];
	} else {
		return valueString;
	}
}

@end
