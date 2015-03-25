//
//  HNKLookup.h
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

@class HNKWordOfTheDay;

@interface HNKLookup : NSObject

#pragma mark - Initialization

/**
 *  Sets up shared HNKLookup instance with provided API key
 */
+ (instancetype)sharedInstanceWithAPIKey:(NSString *)apiKey;

/**
 * Returns shared HNKLookup instance
 */
+ (instancetype)sharedInstance;

#pragma mark - Lookups

/**
 *  Retrieves an array of definitions
 *
 *  @param word       Word to be defined
 *  @param completion A block to be executed when the request finishes
 *
 *  @return Identifier for this request
 */
- (NSUInteger)definitionsForWord:(NSString *)word
                      completion:(void (^)(NSArray *definitions,
                         NSError *error))completion;

/**
 *  Retrieves an array of definitions with only the specified part of speech
 *
 *  @param word             Word to be defined
 *  @param partsOfSpeech    Parts of speech the definitions can be
 *  @param completion       A block to be executed when the request finishes
 *
 *  @return Identifier for this request
 */
- (NSUInteger)definitionsForWord:(NSString *)word
               withPartsOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech
                      completion:(void (^)(NSArray *definitions,
                         NSError *error))completion;

/**
 *  Retrieves an array of pronunciations
 *
 *  @param word         Word to retrieve pronunciations for
 *  @param completion   A block to be executed when the request finishes
 *
 *  @return Identifier for this request
 */
- (NSUInteger)pronunciationsForWord:(NSString *)word
                         completion:(void (^)(NSArray *pronunciations,
                         NSError *error))completion;

/**
 *  Retrieves a random word
 *
 *  @param completion A block to be executed when the request finishes
 *
 *  @return Identifier for this request
 */
- (NSUInteger)randomWordWithCompletion:(void (^)(NSString *randomWord,
                                                 NSError *error))completion;

/**
 *  Retrieves the Word of the Day
 *
 *  @param completion   A block to be executed when the request finishes
 *
 *  @return Identifier for this request
 */
- (NSUInteger)wordOfTheDayWithCompletion:(void (^)(HNKWordOfTheDay *wordOfTheDay,
                                                   NSError *error))completion;

/**
 *  Retrieves the Word of the Day for a given date
 *
 *  @param date       Date for which to fetch the Word of the Day
 *  @param completion A block to be executed when the request finishes
 *
 *  @return Identifier for this request
 */
- (NSUInteger)wordOfTheDayForDate:(NSDate *)date
                       completion:(void (^)(HNKWordOfTheDay *wordOfTheDay,
                         NSError *error))completion;

@end
