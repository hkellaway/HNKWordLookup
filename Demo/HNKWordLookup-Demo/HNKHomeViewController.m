//
//  HNKHomeViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKDefinitionsViewController.h"
#import "HNKHomeViewController.h"

#import <HNKWordLookup/HNKWordLookup.h>

#warning Replace YOUR_API_KEY with your API key
static NSString *const kHNKApiKey =
    @"6c178ad0c2380bea5f47519d6924aade3522e60a23fa51db1";
static NSString *const kHNKSegueShowDefinitionsForWordOfTheDay =
    @"HNKSegueShowDefinitionsForWordOfTheDay";

@interface HNKHomeViewController () <HNKLookupDelegate>

@property (nonatomic, strong) HNKLookup *lookup;
@property (nonatomic, copy) HNKWordOfTheDay *wordOfTheDay;

@property (weak, nonatomic) IBOutlet UITextField *definitionsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pronunciationsTextField;

@end

@implementation HNKHomeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [HNKLookup sharedInstanceWithAPIKey:kHNKApiKey];

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
  if ([segue.identifier
          isEqualToString:kHNKSegueShowDefinitionsForWordOfTheDay]) {

    HNKDefinitionsViewController *destinationController =
        segue.destinationViewController;

    void (^fetchCompletion)(NSString *, NSError *) =
        ^(NSString *wordOfTheDay, NSError *error) {

          if (error) {
            [self handleError:error];
          }

          destinationController.word = wordOfTheDay;

        };

    [self fetchWordOfTheDayWithCompletion:fetchCompletion];
  }
}

#pragma mark - Helpers

- (void)handleError:(NSError *)error
{
  NSLog(@"HNKWordLookup-Demo Error: %@", error);
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
         self.wordOfTheDay.datePublished < [NSDate date];
}

- (void)cacheWordOfTheDay:(HNKWordOfTheDay *)wordOfTheDay
{
  self.wordOfTheDay = wordOfTheDay;
}

@end
