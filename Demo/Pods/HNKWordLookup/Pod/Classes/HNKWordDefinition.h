//
//  HNKWordDefinition.h
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

#import <Mantle/Mantle.h>

/**
 Parts of speech
 
 @discussion `HNKWordDefinitionPartOfSpeech` is an enum, so its values support math operations.
 
    The underlying values are bitmasked to facilitate being combined together with an `|` operator. See: https://developer.apple.com/library/ios/releasenotes/ObjectiveC/ModernizationObjC/AdoptingModernObjective-C/AdoptingModernObjective-C.html#//apple_ref/doc/uid/TP40014150-CH1-SW6
 
    Note: Excluding the default value `HNKWordDefinitionPartOfSpeechUnknown`, the enum values are in alphabetical order by part of speech - e.g. Adjective comes before Adverb.
 */
typedef NS_OPTIONS (NSInteger, HNKWordDefinitionPartOfSpeech) {
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

@end
