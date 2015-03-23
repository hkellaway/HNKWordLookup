//
//  HNKRandomWord.m
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/20/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKRandomWord.h"

@implementation HNKRandomWord

#pragma mark - Protocol conformance

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{
		       @"word"    : @"word"
	};
}

@end
