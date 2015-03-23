//
//  HNKDataSource.h
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/15/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKWordDefinition.h"

@class HNKWordOfTheDay;

@interface HNKWordLookup : NSObject

#pragma mark - Initialization

/**
 *  Sets up shared HNKWordLookup instance with provided API key
 */
+(instancetype)sharedInstanceWithAPIKey:(NSString *)apiKey;

/**
 * Returns shared HNKWordLookup instance
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
        withCompletion:(void (^)(NSArray *definitions,
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
