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
static NSString *const kHNKApiKey = @"YOUR_API_KEY";
static NSString *const kHNKSegueShowDefinitionsForWordOfTheDay =
    @"HNKSegueShowDefinitionsForWordOfTheDay";

@interface HNKHomeViewController ()

@property (nonatomic, strong) HNKLookup *lookup;
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

    [self.lookup wordOfTheDayWithCompletion:^(HNKWordOfTheDay *wordOfTheDay,
                                              NSError *error) {
      destinationController.wordToDefine = wordOfTheDay.word;
    }];
  }
}

@end
