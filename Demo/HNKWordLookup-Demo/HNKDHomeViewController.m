//
//  HNKHomeViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKDDefinitionsViewController.h"
#import "HNKDHomeViewController.h"
#import "HNKDWordLookup.h"

#import "NSDate+HNKDAdditions.h"

static NSString *const kHNKDemoHNKSegueShowDefinitionsForWord =
    @"HNKSegueShowDefinitionsForWord";
static NSString *const kHNKDemoHNKSegueShowDefinitionsForRandomWord =
    @"HNKSegueShowDefinitionsForRandomWord";
static NSString *const kHNKDemoSegueShowDefinitionsForWordOfTheDay =
    @"SegueShowDefinitionsForWordOfTheDay";

@interface HNKDHomeViewController ()

@property (nonatomic, strong) HNKDWordLookup *wordLookup;

@property (weak, nonatomic) IBOutlet UITextField *definitionsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pronunciationsTextField;

@end

@implementation HNKDHomeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.wordLookup = [[HNKDWordLookup alloc] init];
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
      [self.wordLookup fetchRandomWordWithCompletion:fetchCompletion];
    }

    if ([segue.identifier
            isEqualToString:kHNKDemoSegueShowDefinitionsForWordOfTheDay]) {
      [self.wordLookup fetchWordOfTheDayWithCompletion:fetchCompletion];
    }
  }
}

#pragma mark - Helpers

- (void)handleError:(NSError *)error
{
  NSLog(@"HNKWordLookup-Demo Error: %@", error);
}

@end
