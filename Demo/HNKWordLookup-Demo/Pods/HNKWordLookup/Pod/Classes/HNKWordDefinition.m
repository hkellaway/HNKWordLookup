//
//  HNKWordDefinition.m
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/14/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKWordDefinition.h"

static NSDictionary *HNKPartsOfSpeechDictionary;

@implementation HNKWordDefinition

#pragma mark - Getters

- (NSString *)partOfSpeechString
{
	NSString *partOfSpeechString = [[HNKPartsOfSpeechDictionary allKeysForObject:@(self.partOfSpeech)] firstObject];

	return (partOfSpeechString) ? partOfSpeechString : @"Unknown";
}

#pragma mark - Instance methods

- (BOOL)isNoun
{
	return self.partOfSpeech == HNKWordDefinitionPartOfSpeechNoun
	       || self.partOfSpeech == HNKWordDefinitionPartOfSpeechNounPlural
	       || self.partOfSpeech == HNKWordDefinitionPartOfSpeechNounPosessive
	       || self.partOfSpeech == HNKWordDefinitionPartOfSpeechNounProperPlural
	       || self.partOfSpeech == HNKWordDefinitionPartOfSpeechNounProperPosessive;
}

- (BOOL)isVerb
{
	return self.partOfSpeech == HNKWordDefinitionPartOfSpeechVerb
	       || self.partOfSpeech == HNKWordDefinitionPartOfSpeechVerbAuxiliary
	       || self.partOfSpeech == HNKWordDefinitionPartOfSpeechVerbIntransitive
	       || self.partOfSpeech == HNKWordDefinitionPartOfSpeechVerbTransitive;
}

#pragma mark - Override

- (NSString *)description
{
	return [NSString stringWithFormat:@"Definition: %@; Word: %@; Part of Speech: %@; Attribution: %@", self.definitionText, self.word, self.partOfSpeechString, self.attribution];
}

#pragma mark - Protocol conformance

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
	return @{
		       @"definitionText"    : @"text",
		       @"word"              : @"word",
		       @"partOfSpeech"      : @"partOfSpeech",
		       @"attribution"       : @"attributionText"
	};
}

+ (NSValueTransformer *)partOfSpeechJSONTransformer
{
	HNKPartsOfSpeechDictionary = @{
		@"abbreviation"             : @(HNKWordDefinitionPartOfSpeechAbbreviation),
		@"adjective"                : @(HNKWordDefinitionPartOfSpeechAdjective),
		@"adverb"                   : @(HNKWordDefinitionPartOfSpeechAdverb),
		@"affix"                    : @(HNKWordDefinitionPartOfSpeechAffix),
		@"article"                  : @(HNKWordDefinitionPartOfSpeechArticle),
		@"definite-article"         : @(HNKWordDefinitionPartOfSpeechArticleDefinite),
		@"conjunction"              : @(HNKWordDefinitionPartOfSpeechConjunction),
		@"idiom"                    : @(HNKWordDefinitionPartOfSpeechIdiom),
		@"imperative"               : @(HNKWordDefinitionPartOfSpeechImperative),
		@"interjection"             : @(HNKWordDefinitionPartOfSpeechInterjection),
		@"family-name"              : @(HNKWordDefinitionPartOfSpeechNameFamily),
		@"given-name"               : @(HNKWordDefinitionPartOfSpeechNameGiven),
		@"noun"                     : @(HNKWordDefinitionPartOfSpeechNoun),
		@"noun-plural"              : @(HNKWordDefinitionPartOfSpeechNounPlural),
		@"noun-posessive"           : @(HNKWordDefinitionPartOfSpeechNounPosessive),
		@"proper-noun-plural"       : @(HNKWordDefinitionPartOfSpeechNounProperPlural),
		@"proper-noun-possessive"   : @(HNKWordDefinitionPartOfSpeechNounProperPosessive),
		@"past-participle"          : @(HNKWordDefinitionPartOfSpeechParticiplePast),
		@"phrasal-prefix"           : @(HNKWordDefinitionPartOfSpeechPrefixPhrasal),
		@"preposition"              : @(HNKWordDefinitionPartOfSpeechPreposition),
		@"pronoun"                  : @(HNKWordDefinitionPartOfSpeechPronoun),
		@"suffix"                   : @(HNKWordDefinitionPartOfSpeechSuffix),
		@"verb"                     : @(HNKWordDefinitionPartOfSpeechVerb),
		@"auxiliary-verb"           : @(HNKWordDefinitionPartOfSpeechVerbAuxiliary),
		@"verb-intransitive"        : @(HNKWordDefinitionPartOfSpeechVerbIntransitive),
		@"verb-transitive"          : @(HNKWordDefinitionPartOfSpeechVerbTransitive)
	};

	return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:HNKPartsOfSpeechDictionary];
}

#pragma mark - Helpers

- (NSString *)stringForPartOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech
{
	NSString *partOfSpeechString = [[HNKPartsOfSpeechDictionary allKeysForObject:@(partOfSpeech)] firstObject];

	return (partOfSpeechString) ? partOfSpeechString : @"Unknown";
}

@end
