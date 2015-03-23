//
//  HNKWordPronunciation.m
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/19/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKWordPronunciation.h"

@implementation HNKWordPronunciation

#pragma mark - Protocol conformance

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{
		       @"pronunciationText"   : @"raw",
		       @"format"              : @"rawType"
	};
}

+ (NSValueTransformer *)formatJSONTransformer
{
	NSDictionary *formatsDictionary = @{
		@"ahd-legacy"        : @(HNKWordPronunciationFormatAHD),
		@"arpabet"           : @(HNKWordPronunciationFormatArpabet),
		@"gcide-diacritical" : @(HNKWordPronunciationFormatGcideDiacritical),
		@"ipa"               : @(HNKWordPronunciationFormatIPA)
	};

	return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:formatsDictionary];
}

@end
