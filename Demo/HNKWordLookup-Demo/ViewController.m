//
//  ViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 3/22/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "ViewController.h"

#import <HNKWordLookup/HNKWordLookup.h>
#import "NSDate+HNKAdditions.h"

#warning Replace YOUR_API_KEY with your API key
static NSString *const kHNKDemoApiKey = @"YOUR_API_KEY";

@interface ViewController () <HNKLookupDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [HNKLookup sharedInstanceWithAPIKey:kHNKDemoApiKey];

  HNKLookup *lookup = [HNKLookup sharedInstance];
  lookup.delegate = self;

  [lookup definitionsForWord:@"center"
                  completion:^(NSArray *definitions, NSError *error) {
                    if (error) {
                      NSLog(@"ERROR: %@", error);
                    } else {
                      NSLog(@"%li DEFINITIONS:", (long)[definitions count]);

                      for (HNKWordDefinition *definition in definitions) {
                        NSLog(@"%@", definition);
                      }
                    }
                  }];

  [lookup definitionsForWord:@"center"
           withPartsOfSpeech:HNKWordDefinitionPartOfSpeechNoun |
                             HNKWordDefinitionPartOfSpeechVerbTransitive
                  completion:^(NSArray *definitions, NSError *error) {
                    if (error) {
                      NSLog(@"ERROR: %@", error);
                    } else {
                      NSLog(@"%li DEFINITIONS WITH PART OF SPEECH:",
                            (long)[definitions count]);

                      for (HNKWordDefinition *definition in definitions) {
                        NSLog(@"%@", definition.partOfSpeechString);
                      }
                    }
                  }];

  [lookup pronunciationsForWord:@"orange"
                     completion:^(NSArray *pronunciations, NSError *error) {
                       if (error) {
                         NSLog(@"ERROR: %@", error);
                       } else {
                         NSLog(@"PRONUNCIATIONS:");

                         for (HNKWordPronunciation *pronunciation in
                                  pronunciations) {
                           NSLog(@"%@", pronunciation.pronunciationText);
                         }
                       }
                     }];

  [lookup wordOfTheDayWithCompletion:^(HNKWordOfTheDay *wordOfTheDay,
                                       NSError *error) {
    if (error) {
      NSLog(@"ERROR: %@", error);
    } else {
      NSLog(@"WORD OF THE DAY: %@ %@",
            wordOfTheDay.word,
            wordOfTheDay.datePublished);
    }
  }];

  [lookup wordOfTheDayForDate:
              [NSDate hnk_dateFromString:@"2015-03-01T00:00:00.000+0000"]
                   completion:^(HNKWordOfTheDay *wordOfTheDay, NSError *error) {
                     if (error) {
                       NSLog(@"ERROR: %@", error);
                     } else {
                       NSLog(@"WORD OF THE DAY FOR DATE: %@", wordOfTheDay);
                     }
                   }];

  [lookup randomWordWithCompletion:^(NSString *randomWord, NSError *error) {
    if (error) {
      NSLog(@"ERROR: %@", error);
    } else {
      NSLog(@"RANDOM WORD: %@", randomWord);
    }
  }];
}

#pragma mark - Protocol conformance

#pragma mark <HNKLookupDelegate>

- (BOOL)shouldDisplayNetworkActivityIndicator
{
  return YES;
}

@end
