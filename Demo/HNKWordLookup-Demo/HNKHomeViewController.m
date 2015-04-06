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

@interface HNKHomeViewController ()

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
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier
          isEqualToString:kHNKSegueShowDefinitionsForWordOfTheDay]) {

    HNKDefinitionsViewController *destinationController =
        segue.destinationViewController;

    if ([self shouldFetchWordOfTheDay]) {
      void (^fetchCompletion)(HNKWordOfTheDay *, NSError *);
      fetchCompletion = ^(HNKWordOfTheDay *wordOfTheDay, NSError *error) {
        [self cacheWordOfTheDay:wordOfTheDay];
        destinationController.word = wordOfTheDay.word;
      };

      [self fetchWordOfTheDayWithCompletion:fetchCompletion];
    } else {
      destinationController.word = self.wordOfTheDay.word;
    }
  }
}

#pragma mark - Helpers

- (BOOL)shouldFetchWordOfTheDay
{
  NSDate *sourceDate = self.wordOfTheDay.datePublished;

  NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
  NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];

  NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
  NSInteger destinationGMTOffset =
      [destinationTimeZone secondsFromGMTForDate:sourceDate];
  NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;

  NSDate *destinationDate =
      [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];

  NSLog(@"%@", destinationDate);

  if ((self.wordOfTheDay == nil) ||
      [self.wordOfTheDay datePublished] < [NSDate date]) {
    return YES;
  }

  return NO;
}

- (void)fetchWordOfTheDayWithCompletion:(void (^)(HNKWordOfTheDay *,
                                                  NSError *))completion
{
  [self.lookup wordOfTheDayWithCompletion:completion];
}

- (void)cacheWordOfTheDay:(HNKWordOfTheDay *)wordOfTheDay
{
  self.wordOfTheDay = wordOfTheDay;
}

@end
