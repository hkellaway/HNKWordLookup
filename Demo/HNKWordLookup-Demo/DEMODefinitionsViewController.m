//
//  DEMODefinitionsViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "DEMODefinitionsViewController.h"

static NSString *const kDemoPlaceholderText = @"Loading...";

@interface DEMODefinitionsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIView *activityIndicator;

@end

@implementation DEMODefinitionsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.wordLabel.text =
      self.word ? self.word : NSLocalizedString(kDemoPlaceholderText, @"");
}

#pragma mark - Setters

- (void)setWord:(NSString *)word
{
  _word = word;

  self.wordLabel.text = word;
}

@end
