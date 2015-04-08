//
//  HNKHomeViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKDDefinitionsViewController.h"
#import "HNKDHomeViewController.h"

#import "NSDate+HNKDAdditions.h"

#import <HNKWordLookup/HNKWordLookup.h>

#warning Replace YOUR_API_KEY with your API key
static NSString *const kHNKDemoApiKey =
    @"6c178ad0c2380bea5f47519d6924aade3522e60a23fa51db1";
static NSString *const kHNKDemoHNKSegueShowDefinitionsForWord =
    @"HNKSegueShowDefinitionsForWord";
static NSString *const kHNKDemoHNKSegueShowDefinitionsForRandomWord =
    @"HNKSegueShowDefinitionsForRandomWord";
static NSString *const kHNKDemoSegueShowDefinitionsForWordOfTheDay =
    @"SegueShowDefinitionsForWordOfTheDay";

@interface HNKDHomeViewController () <HNKLookupDelegate>

@property (nonatomic, strong) HNKLookup *lookup;
@property (nonatomic, copy) HNKWordOfTheDay *wordOfTheDay;

@property (weak, nonatomic) IBOutlet UITextField *definitionsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pronunciationsTextField;

@end

@implementation HNKDHomeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [HNKLookup sharedInstanceWithAPIKey:kHNKDemoApiKey];

  self.lookup = [HNKLookup sharedInstance];
  self.lookup.delegate = self;
}

#pragma mark - Protocol conformance

#pragma mark <HNKLookupDelegate>

- (BOOL)shouldDisplayNetworkActivityIndicator
{
  return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  id destinationController = segue.destinationViewController;

  if ([destinationController
          isKindOfClass:[HNKDDefinitionsViewController class]]) {

    HNKDDefinitionsViewController *definitionsController =
        (HNKDDefinitionsViewController *)destinationController;

    void (^fetchCompletion)(NSString *, NSError *) =
        ^(NSString *word, NSError *error) {

          if (error) {
            [self handleError:error];
          }

          definitionsController.word = word;

        };

    if ([segue.identifier
            isEqualToString:kHNKDemoHNKSegueShowDefinitionsForWord]) {
      fetchCompletion(self.definitionsTextField.text, nil);
    }

    if ([segue.identifier
            isEqualToString:kHNKDemoHNKSegueShowDefinitionsForRandomWord]) {
      [self fetchRandomWordWithCompletion:fetchCompletion];
    }

    if ([segue.identifier
            isEqualToString:kHNKDemoSegueShowDefinitionsForWordOfTheDay]) {
      [self fetchWordOfTheDayWithCompletion:fetchCompletion];
    }
  }
}

#pragma mark - Helpers

- (void)handleError:(NSError *)error
{
  NSLog(@"HNKWordLookup-Demo Error: %@", error);
}

- (void)fetchRandomWordWithCompletion:(void (^)(NSString *,
                                                NSError *))completion
{
  [self.lookup
      randomWordWithCompletion:^(NSString *randomWord, NSError *error) {
        if (error) {
          completion(nil, error);
        }

        completion(randomWord, error);
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

      [self cacheWordOfTheDay:wordOfTheDay];
      completion(wordOfTheDay.word, nil);

    }];
  } else {
    completion(self.wordOfTheDay.word, nil);
  }
}

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
