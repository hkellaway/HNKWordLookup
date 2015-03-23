//
//  HNKWordPronunciation.h
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/19/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef NS_ENUM (NSInteger, HNKWordPronunciationFormat) {
	HNKWordPronunciationFormatAHD,
	HNKWordPronunciationFormatArpabet,
	HNKWordPronunciationFormatGcideDiacritical,
	HNKWordPronunciationFormatIPA
};

@interface HNKWordPronunciation : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *pronunciationText;
@property (nonatomic, assign) HNKWordPronunciationFormat format;

@end
