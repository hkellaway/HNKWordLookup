//
//  HNKWordDefinition.h
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/14/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef NS_ENUM (NSInteger, HNKWordDefinitionPartOfSpeech) {
	HNKWordDefinitionPartOfSpeechUnknown                = 0,
	HNKWordDefinitionPartOfSpeechAbbreviation           = 1 << 0,
	        HNKWordDefinitionPartOfSpeechAdjective              = 1 << 1,
	        HNKWordDefinitionPartOfSpeechAdverb                 = 1 << 2,
	        HNKWordDefinitionPartOfSpeechAffix                  = 1 << 3,
	        HNKWordDefinitionPartOfSpeechArticle                = 1 << 4,
	        HNKWordDefinitionPartOfSpeechArticleDefinite        = 1 << 5,
	        HNKWordDefinitionPartOfSpeechConjunction            = 1 << 6,
	        HNKWordDefinitionPartOfSpeechIdiom                  = 1 << 7,
	        HNKWordDefinitionPartOfSpeechImperative             = 1 << 8,
	        HNKWordDefinitionPartOfSpeechInterjection           = 1 << 9,
	        HNKWordDefinitionPartOfSpeechNameFamily             = 1 << 10,
	        HNKWordDefinitionPartOfSpeechNameGiven              = 1 << 11,
	        HNKWordDefinitionPartOfSpeechNoun                   = 1 << 12,
	        HNKWordDefinitionPartOfSpeechNounPlural             = 1 << 13,
	        HNKWordDefinitionPartOfSpeechNounProperPlural       = 1 << 14,
	        HNKWordDefinitionPartOfSpeechNounProperPosessive    = 1 << 15,
	        HNKWordDefinitionPartOfSpeechNounPosessive          = 1 << 16,
	        HNKWordDefinitionPartOfSpeechParticiplePast         = 1 << 17,
	        HNKWordDefinitionPartOfSpeechPrefixPhrasal          = 1 << 18,
	        HNKWordDefinitionPartOfSpeechPreposition            = 1 << 19,
	        HNKWordDefinitionPartOfSpeechPronoun                = 1 << 20,
	        HNKWordDefinitionPartOfSpeechSuffix                 = 1 << 21,
	        HNKWordDefinitionPartOfSpeechVerb                   = 1 << 22,
	        HNKWordDefinitionPartOfSpeechVerbAuxiliary          = 1 << 23,
	        HNKWordDefinitionPartOfSpeechVerbIntransitive       = 1 << 24,
	        HNKWordDefinitionPartOfSpeechVerbTransitive         = 1 << 25
};

@interface HNKWordDefinition : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *definitionText;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, assign) HNKWordDefinitionPartOfSpeech partOfSpeech;
@property (nonatomic, readonly) NSString *partOfSpeechString;
@property (nonatomic, copy) NSString *attribution;

- (BOOL)isNoun;
- (BOOL)isVerb;

@end
