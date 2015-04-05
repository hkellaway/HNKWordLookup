//
//  HNKHttpSessionManager.m
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

#import "HNKHttpSessionManager.h"
#import "NSDate+HNKAdditions.h"

#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#pragma mark - Constants

static NSString *const kHNKApiKeyParameterName = @"api_key";

#pragma mark Paths

static NSString *const kHNKPathDefinitions = @"word.json/%@/definitions";
static NSString *const kHNKPathPronunciations = @"word.json/%@/pronunciations";
static NSString *const kHNKPathRandomWord = @"words.json/randomWord";
static NSString *const kHNKPathWordOfTheDay = @"words.json/wordOfTheDay";

@interface HNKHttpSessionManager ()

@property (nonatomic, copy) NSString *apiKey;

@end

@implementation HNKHttpSessionManager

#pragma mark - Initialization

static HNKHttpSessionManager *sharedManager = nil;

+ (void)setupSharedManager:(NSURL *)url apiKey:(NSString *)apiKey
{
  [self sharedManagerWithURL:url apiKey:apiKey];
}

+ (instancetype)sharedManagerWithURL:(NSURL *)url apiKey:(NSString *)apiKey
{
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken,
                ^{
                  NSParameterAssert(url);
                  NSParameterAssert(apiKey);

                  sharedManager = [[self alloc] initWithBaseURL:url];

                  sharedManager.apiKey = apiKey;
                  sharedManager.responseSerializer.acceptableContentTypes =
                      [NSSet setWithObject:@"application/json"];
                });

  return sharedManager;
}

#pragma mark - Class methods

#pragma mark Activity Indicator

+ (void)displayActivityIndicator:(BOOL)shouldDisplayActivityIndicator
{
  [[AFNetworkActivityIndicatorManager sharedManager]
      setEnabled:shouldDisplayActivityIndicator];
}

#pragma mark Requests

+ (NSUInteger)definitionsForWord:(NSString *)word
                      completion:(void (^)(NSURLSessionDataTask *, id,
                                           NSError *))completion
{
  return [self
      startRequestWithPath:[NSString stringWithFormat:kHNKPathDefinitions, word]
                parameters:nil
                completion:completion];
}

+ (NSUInteger)pronunciationsForWord:(NSString *)word
                         completion:(void (^)(NSURLSessionDataTask *, id,
                                              NSError *))completion
{
  return [self
      startRequestWithPath:[NSString
                               stringWithFormat:kHNKPathPronunciations, word]
                parameters:nil
                completion:completion];
}

+ (NSUInteger)randomWordWithCompletion:(void (^)(NSURLSessionDataTask *, id,
                                                 NSError *))completion
{
  return [self startRequestWithPath:kHNKPathRandomWord
                         parameters:@{
                           @"hasDictionaryDef" : @"true",
                           @"minCorpusCount" : @(0),
                           @"maxCorpusCount" : @(-1),
                           @"minDictionaryCount" : @(1),
                           @"maxDictionaryCount" : @(-1),
                           @"minLength" : @(3),
                           @"maxLength" : @(-1)
                         }
                         completion:completion];
}

+ (NSUInteger)wordOfTheDayForDate:(NSDate *)date
                       completion:(void (^)(NSURLSessionDataTask *, id,
                                            NSError *))completion
{
  int day = (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                  fromDate:date] day];
  int month = (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitMonth
                                                    fromDate:date] month];
  int year = (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                                   fromDate:date] year];

  NSString *dateString =
      [NSDate hnk_stringFromDateWithYear:year month:month day:day];

  return [self startRequestWithPath:kHNKPathWordOfTheDay
                         parameters:@{
                           @"date" : dateString
                         }
                         completion:completion];
}

#pragma mark - Helper methods

+ (NSUInteger)startRequestWithPath:(NSString *)path
                        parameters:(id)parameters
                        completion:(void (^)(NSURLSessionDataTask *task,
                                             id responseObject,
                                             NSError *error))completion
{
  NSURLSessionDataTask *newTask = nil;

  void (^success)(NSURLSessionDataTask *, id);
  success = ^(NSURLSessionDataTask *task, id responseObject) {
    completion(task, responseObject, nil);
  };

  void (^failure)(NSURLSessionDataTask *, NSError *);
  failure = ^(NSURLSessionDataTask *task, NSError *error) {
    completion(task, nil, error);
  };

  NSString *fullPath = [[sharedManager.baseURL absoluteString]
      stringByAppendingPathComponent:path];
  parameters = [self parameters:parameters withApiKey:sharedManager.apiKey];

  newTask = [sharedManager GET:fullPath
                    parameters:parameters
                       success:success
                       failure:failure];

  return newTask.taskIdentifier;
}

+ (NSDictionary *)parameters:(NSDictionary *)parameters
                  withApiKey:(NSString *)apiKey
{
  if (parameters == nil) {
    parameters = @{kHNKApiKeyParameterName : apiKey};
  } else {
    NSMutableDictionary *mutableParameters = [parameters mutableCopy];
    [mutableParameters setValue:apiKey forKey:kHNKApiKeyParameterName];
    parameters = [mutableParameters copy];
  }

  return parameters;
}

@end
