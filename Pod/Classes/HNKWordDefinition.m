//
//  HNKWordDefinition.m
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

#import "HNKWordDefinition.h"

static NSDictionary *HNKPartsOfSpeechDictionary;

@implementation HNKWordDefinition

#pragma mark - Getters

- (NSString *)partOfSpeechString {
	NSString *partOfSpeechString = [[HNKPartsOfSpeechDictionary allKeysForObject:@(self.partOfSpeech)] firstObject];

	return (partOfSpeechString) ? partOfSpeechString : @"Unknown";
}

#pragma mark - Override

- (NSString *)description {
	return [NSString stringWithFormat:@"Definition: %@; Word: %@; Part of Speech: %@; Attribution: %@", self.definitionText, self.word, self.partOfSpeechString, self.attribution];
}

#pragma mark - Protocol conformance

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			   @"definitionText"    : @"text",
			   @"word"              : @"word",
			   @"partOfSpeech"      : @"partOfSpeech",
			   @"attribution"       : @"attributionText"
	};
}

+ (NSValueTransformer *)partOfSpeechJSONTransformer {
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

@end
