//
//  HNKDWordLookup.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/7/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKDWordLookup.h"

#import <HNKWordLookup/HNKWordLookup.h>

#import "NSDate+HNKDAdditions.h"

#warning Replace YOUR_API_KEY with your API key
static NSString *const kDemoApiKey =
    @"6c178ad0c2380bea5f47519d6924aade3522e60a23fa51db1";

@interface HNKDWordLookup () <HNKLookupDelegate>

@property (nonatomic, strong) HNKLookup *lookup;
@property (nonatomic, strong) HNKWordOfTheDay *wordOfTheDay;

@end

@implementation HNKDWordLookup

#pragma mark - Initialization

- (instancetype)init
{
  self = [super init];

  if (self) {
    [HNKLookup sharedInstanceWithAPIKey:kDemoApiKey];

    self.lookup = [HNKLookup sharedInstance];
    self.lookup.delegate = self;
  }

  return self;
}

#pragma mark - Lookups

- (void)fetchRandomWordWithCompletion:(void (^)(NSString *,
                                                NSError *))completion
{
  [self.lookup
      randomWordWithCompletion:^(NSString *randomWord, NSError *error) {
        if (error) {
          completion(nil, error);
        }

        completion(randomWord, nil);
      }];
}

- (void)fetchWordOfTheDayWithCompletion:(void (^)(NSString *,
                                                  NSError *))completion
{
  if ([self shouldFetchWordOfTheDay]) {

    [self.lookup wordOfTheDayWithCompletion:^(HNKWordOfTheDay *wordOfTheDay,
                                              NSError *error) {
      if (error) {
        completion(nil, error);
      }

      completion(wordOfTheDay.word, nil);
    }];

  } else {
    completion(self.wordOfTheDay.word, nil);
  }
}

#pragma mark - Protocol conformance

#pragma mark <HNKLookupDelegate>

- (BOOL)shouldDisplayNetworkActivityIndicator
{
  return YES;
}

#pragma mark - Helpers

- (BOOL)shouldFetchWordOfTheDay
{
  return (self.wordOfTheDay == nil) ||
         ![self.wordOfTheDay.datePublished hnkd_isToday];
}

- (void)cacheWordOfTheDay:(HNKWordOfTheDay *)wordOfTheDay
{
  self.wordOfTheDay = wordOfTheDay;
}

@end
