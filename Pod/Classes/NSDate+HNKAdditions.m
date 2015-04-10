//
//  NSDate+HNKAdditions.m
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "NSDate+HNKAdditions.h"

static NSString *const kHNKDateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";

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

  return [NSString
      stringWithFormat:@"%@-%@-%@", yearString, monthString, dayString];
}

#pragma mark - Helpers

+ (NSDateFormatter *)dateFormatter
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = kHNKDateFormat;

  return dateFormatter;
}

+ (NSString *)dateStringForValue:(int)value
{
  NSString *valueString = [NSString stringWithFormat:@"%i", value];

  if ([valueString length] == 1) {
    return [NSString stringWithFormat:@"%i%@", 0, valueString];
  } else {
    return valueString;
  }
}

@end