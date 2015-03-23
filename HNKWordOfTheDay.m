//
//  HNKWordOfTheDay.m
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/19/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKWordDefinition.h"
#import "HNKWordLookup.h"
#import "HNKWordOfTheDay.h"

#import "NSDate+HNKAdditions.h"

@implementation HNKWordOfTheDay

#pragma mark - Protocol conformance

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{
		       @"word"          : @"word",
		       @"datePublished" : @"publishDate"
	};
}

#pragma mark - Helpers

+ (NSValueTransformer *)datePublishedJSONTransformer
{
	return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
	                NSDate *date = [NSDate hnk_dateFromString:str];
	                return date;
		} reverseBlock:^(NSDate *date) {
	                return [NSDate hnk_stringFromDate:date];
		}];
}

@end
