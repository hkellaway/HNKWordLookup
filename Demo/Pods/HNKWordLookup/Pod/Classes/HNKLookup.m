//
//  HNKLookup.m
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

#import "HNKLookup.h"
#import "HNKHttpSessionManager.h"
#import "HNKWordDefinition.h"
#import "HNKWordOfTheDay.h"
#import "HNKWordPronunciation.h"

#import <Mantle/MTLJSONAdapter.h>

static NSString *const kHNKLookupBaseUrl = @"http://api.wordnik.com:80/v4";

@implementation HNKLookup

#pragma mark - Initialization

static HNKLookup *sharedInstance = nil;

+ (instancetype)sharedInstanceWithAPIKey:(NSString *)apiKey
{
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken,
                ^{
                  sharedInstance = [[self alloc] initWithAPIKey:apiKey];
                });

  return sharedInstance;
}

+ (instancetype)sharedInstance
{
  if (sharedInstance == nil) {
    NSAssert(
        FALSE,
        @"sharedInstance should not be called before sharedInstanceWithAPIKey");
  }

  return sharedInstance;
}

- (instancetype)initWithAPIKey:(NSString *)apiKey
{
  self = [super init];

  if (self) {
    NSURL *url = [NSURL URLWithString:kHNKLookupBaseUrl];
    [HNKHttpSessionManager setupSharedManager:url apiKey:apiKey];
  }

  return self;
}

#pragma mark - Setters

- (void)setDelegate:(id<HNKLookupDelegate>)delegate
{
  _delegate = delegate;

  if (self.delegate &&
      [self.delegate
          respondsToSelector:@selector(
                                 shouldDisplayNetworkActivityIndicator)]) {
    BOOL shouldDisplayActivityIndicator =
        [self.delegate shouldDisplayNetworkActivityIndicator];
    [HNKHttpSessionManager
        displayActivityIndicator:shouldDisplayActivityIndicator];
  }
}

#pragma mark - Lookups

- (NSUInteger)definitionsForWord:(NSString *)word
                      completion:(void (^)(NSArray *, NSError *))completion
{
  return [HNKHttpSessionManager
      definitionsForWord:word
              completion:^(NSURLSessionDataTask *task,
                           id responseObject,
                           NSError *error) {
                if (error) {
                  completion(nil, error);
                  return;
                }

                NSError *parseError = nil;
                NSArray *definitions =
                    [self modelsOfClass:[HNKWordDefinition class]
                        fromObjectNotation:responseObject
                                     error:&parseError];

                if (parseError) {
                  completion(nil, parseError);
                  return;
                } else {
                  completion(definitions, nil);
                }
              }];
}

- (NSUInteger)definitionsForWord:(NSString *)word
               withPartsOfSpeech:(HNKWordDefinitionPartOfSpeech)partsOfSpeech
                      completion:(void (^)(NSArray *, NSError *))completion
{
  return [self definitionsForWord:word
                       completion:^(NSArray *definitions, NSError *error) {
                         if (error) {
                           completion(nil, error);
                           return;
                         }

                         completion([self definitions:definitions
                                        filteredByPartOfSpeech:partsOfSpeech],
                                    nil);
                       }];
}

- (NSUInteger)pronunciationsForWord:(NSString *)word
                         completion:(void (^)(NSArray *, NSError *))completion
{
  return [HNKHttpSessionManager
      pronunciationsForWord:word
                 completion:^(NSURLSessionDataTask *task,
                              id responseObject,
                              NSError *error) {
                   if (error) {
                     completion(nil, error);
                     return;
                   }

                   NSError *parseError = nil;
                   NSArray *pronunciations =
                       [self modelsOfClass:[HNKWordPronunciation class]
                           fromObjectNotation:responseObject
                                        error:&parseError];

                   if (parseError) {
                     completion(nil, parseError);
                     return;
                   } else {
                     completion(pronunciations, nil);
                   }
                 }];
}

- (NSUInteger)randomWordWithCompletion:(void (^)(NSString *,
                                                 NSError *))completion
{
  return [HNKHttpSessionManager
      randomWordWithCompletion:^(NSURLSessionDataTask *task,
                                 id responseObject,
                                 NSError *error) {
        if (error) {
          completion(nil, error);
          return;
        }

        NSAssert([responseObject isKindOfClass:[NSDictionary class]],
                 @"Random word object should be a dictionary");

        NSString *randomWord = [responseObject valueForKey:@"word"];
        completion(randomWord, nil);
      }];
}

- (NSUInteger)wordOfTheDayWithCompletion:(void (^)(HNKWordOfTheDay *,
                                                   NSError *))completion
{
  return [self wordOfTheDayForDate:[NSDate date] completion:completion];
}

- (NSUInteger)wordOfTheDayForDate:(NSDate *)date
                       completion:
                           (void (^)(HNKWordOfTheDay *, NSError *))completion
{
  return [HNKHttpSessionManager
      wordOfTheDayForDate:date
               completion:^(NSURLSessionDataTask *task,
                            id responseObject,
                            NSError *error) {
                 if (error) {
                   completion(nil, error);
                   return;
                 }

                 NSError *parseError = nil;
                 NSArray *modelsOfClass =
                     [self modelsOfClass:[HNKWordOfTheDay class]
                         fromObjectNotation:responseObject
                                      error:&parseError];

                 NSAssert([modelsOfClass count] == 1,
                          @"Word of the Day should only return one object");

                 HNKWordOfTheDay *wordOfTheDay =
                     (HNKWordOfTheDay *)[modelsOfClass objectAtIndex:0];

                 if (parseError) {
                   completion(nil, parseError);
                   return;
                 } else {
                   completion(wordOfTheDay, nil);
                 }
               }];
}

#pragma mark - Helpers

- (NSArray *)modelsOfClass:(Class)modelClass
        fromObjectNotation:(id)objectNotation
                     error:(NSError **)error
{
  NSAssert([objectNotation isKindOfClass:[NSArray class]] ||
               [objectNotation isKindOfClass:[NSDictionary class]],
           @"Generic objects should be arrays or dictionaries");

  id parsedModelOfClass = nil;
  NSError *mantleError;

  if ([objectNotation isKindOfClass:[NSArray class]]) {
    parsedModelOfClass = [MTLJSONAdapter modelsOfClass:modelClass
                                         fromJSONArray:objectNotation
                                                 error:&mantleError];
  } else if ([objectNotation isKindOfClass:[NSDictionary class]]) {
    parsedModelOfClass = [MTLJSONAdapter modelOfClass:modelClass
                                   fromJSONDictionary:objectNotation
                                                error:&mantleError];
  }

  if (mantleError) {
    *error = mantleError;
    return nil;
  } else {
    if (![parsedModelOfClass isKindOfClass:[NSArray class]]) {
      return [NSArray arrayWithObject:parsedModelOfClass];
    }

    return parsedModelOfClass;
  }
}

- (NSArray *)definitions:(NSArray *)definitions
    filteredByPartOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech
{
  NSMutableArray *filteredDefinitions = [NSMutableArray array];

  for (HNKWordDefinition *definition in definitions) {
    if ([self isDefinition:definition partOfSpeech:partOfSpeech]) {
      [filteredDefinitions addObject:definition];
    }
  }

  return [filteredDefinitions copy];
}

- (BOOL)isDefinition:(HNKWordDefinition *)definition
        partOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech
{
  HNKWordDefinitionPartOfSpeech firstPartOfSpeech =
      HNKWordDefinitionPartOfSpeechAbbreviation;
  HNKWordDefinitionPartOfSpeech lastPartOfSpeech =
      HNKWordDefinitionPartOfSpeechVerbTransitive;

  for (HNKWordDefinitionPartOfSpeech partOfSpeechToCheck = firstPartOfSpeech;
       partOfSpeechToCheck <= lastPartOfSpeech;
       partOfSpeechToCheck *= 2) {
    if ((definition.partOfSpeech == partOfSpeechToCheck) &&
        [self isPartOfSpeech:partOfSpeechToCheck includedIn:partOfSpeech]) {
      return YES;
    }
  }

  return NO;
}

- (BOOL)isPartOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech
            includedIn:(HNKWordDefinitionPartOfSpeech)partOfSpeechList
{
  return (partOfSpeech | partOfSpeechList) == partOfSpeechList;
}

@end
