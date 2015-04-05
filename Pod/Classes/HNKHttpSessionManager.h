//
//  HNKHttpSessionManager.h
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

#import <AFNetworking/AFHTTPSessionManager.h>

@interface HNKHttpSessionManager : AFHTTPSessionManager

#pragma mark - Initialization

/**
 *  Initializes the HNKHttpSessionManager singleton with a given URL.
 *
 *  @param url A URL to be used as the base URL for all requests.
 */
+ (void)setupSharedManager:(NSURL *)url;

#pragma mark - Activity Indicator

/**
 *  Updates whether the system activity indicator should be displayed during
 *  requests
 */
+ (void)displayActivityIndicator:(BOOL)shouldDisplayActivityIndicator;

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
                      completion:(void (^)(NSURLSessionDataTask *task,
                                           id responseObject,
                                           NSError *error))completion;

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
                         completion:(void (^)(NSURLSessionDataTask *task,
                                              id responseObject,
                                              NSError *error))completion;

/**
 *  Retrieves random word object notation
 *
 *  @param apiKey       API key used in reuqest
 *  @param completion A block to be executed when the request finishes
 *
 *  @return Identifier for the data task used in this request
 */
+ (NSUInteger)randomWordWithApiKey:(NSString *)apiKey
                        completion:(void (^)(NSURLSessionDataTask *task,
                                             id responseObject,
                                             NSError *error))completion;

/**
 *  Retrieves Word of the Day object notation
 *
 *  @param date         Date for which to retrieve the Word of the Day
 *  @param apiKey       API key used in request
 *  @param completion   A block to be executed when the request finishes
 *
 *  @return Identifier for the data task used in the request
 */
+ (NSUInteger)wordOfTheDayForDate:(NSDate *)date
                           apiKey:(NSString *)apiKey
                       completion:(void (^)(NSURLSessionDataTask *task,
                                            id responseObject,
                                            NSError *error))completion;

@end
