//
//  HNKHttpSessionManager.h
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/14/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@interface HNKHttpSessionManager : AFHTTPSessionManager

#pragma mark - Initialization

/**
 *  Initializes the HNKHttpSessionManager singleton with a given URL.
 *
 *  @param url A URL to be used as the base URL for all requests.
 */
+ (void)setupSharedManager:(NSURL *)url;

#pragma mark - Requests

/**
 *  Retrieves definitions object notation
 *
 *  @param word         Word to be defined
 *  @param apiKey       API key used in request
 *  @param completion   A block to be executed when the request finishes
 *
 *  @return Identifier for the data task used in the request
 */
+ (NSUInteger)definitionsForWord:(NSString *)word
        apiKey:(NSString *)apiKey
        completion:( void (^) (NSURLSessionDataTask *task,
                               id responseObject,
                               NSError *error) )completion;

/**
 *  Retrieves pronunciation object notation
 *
 *  @param word         Word to retrieve pronunciations for
 *  @param apiKey       API key used in request
 *  @param completion   A block to be executed when the request finishes
 *
 *  @return Identifier for the data task used in the request
 */
+ (NSUInteger)pronunciationsForWord:(NSString *)word
        apiKey:(NSString *)apiKey
        completion:( void (^) (NSURLSessionDataTask *task,
                               id responseObject,
                               NSError *error) )completion;

/**
 *  Retrieves random word object notation
 *
 *  @param apiKey       API key used in reuqest
 *  @param completion A block to be executed when the request finishes
 *
 *  @return Identifier for the data task used in this request
 */
+ (NSUInteger)randomWordWithApiKey:(NSString *)apiKey completion:( void (^) (NSURLSessionDataTask *task,
                                                                             id responseObject,
                                                                             NSError *error) )completion;

/**
 *  Retrieves Word of the Day for the given date
 *
 *  @param date         Date for which to retrieve the Word of the Day
 *  @param apiKey       API key used in request
 *  @param completion   A block to be executed when the request finishes
 *
 *  @return Identifier for the data task used in the request
 */
+ (NSUInteger)wordOfTheDayForDate:(NSDate *)date
        apiKey:(NSString *)apiKey
        completion:( void (^) (NSURLSessionDataTask *task,
                               id responseObject,
                               NSError *error) )completion;

@end
