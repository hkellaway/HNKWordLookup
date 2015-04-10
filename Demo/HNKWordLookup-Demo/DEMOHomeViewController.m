//
//  DEMOHomeViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "DEMODefinitionsViewController.h"
#import "DEMOHomeViewController.h"
#import "DEMOPronunciationsViewController.h"
#import "DEMOWordLookup.h"

static NSString *const kDemoSegueShowDefinitionsForWord =
    @"SegueShowDefinitionsForWord";
static NSString *const kDemoSegueShowDefinitionsForRandomWord =
    @"SegueShowDefinitionsForRandomWord";
static NSString *const kDemoSegueShowDefinitionsForWordOfTheDay =
    @"SegueShowDefinitionsForWordOfTheDay";

@interface DEMOHomeViewController ()

@property (nonatomic, strong) DEMOWordLookup *wordLookup;

@property (weak, nonatomic) IBOutlet UITextField *definitionsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pronunciationsTextField;

@end

@implementation DEMOHomeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.wordLookup = [[DEMOWordLookup alloc] init];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  id destinationController = segue.destinationViewController;

  if ([destinationController
          isKindOfClass:[DEMOPronunciationsViewController class]]) {

    DEMOPronunciationsViewController *pronunciationsController =
        (DEMOPronunciationsViewController *)destinationController;

    pronunciationsController.word = self.pronunciationsTextField.text;
  }

  if ([destinationController
          isKindOfClass:[DEMODefinitionsViewController class]]) {

    DEMODefinitionsViewController *definitionsController =
        (DEMODefinitionsViewController *)destinationController;

    void (^fetchCompletion)(NSString *, NSError *) =
        ^(NSString *word, NSError *error) {

          if (error) {
            [self handleError:error];
            return;
          }

          definitionsController.word = word;

          [self.wordLookup
              fetchDefinitionsForWord:word
                           completion:^(NSArray *definitions, NSError *error) {
                             if (error) {
                               [self handleError:error];
                               return;
                             }

                             definitionsController.definitions = definitions;
                           }];

        };

    if ([segue.identifier isEqualToString:kDemoSegueShowDefinitionsForWord]) {
      fetchCompletion(self.definitionsTextField.text, nil);
    }

    if ([segue.identifier
            isEqualToString:kDemoSegueShowDefinitionsForRandomWord]) {
      [self.wordLookup fetchRandomWordWithCompletion:fetchCompletion];
    }

    if ([segue.identifier
            isEqualToString:kDemoSegueShowDefinitionsForWordOfTheDay]) {
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
