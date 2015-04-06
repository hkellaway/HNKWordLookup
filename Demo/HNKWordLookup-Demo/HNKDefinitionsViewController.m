//
//  HNKDefinitionsViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKDefinitionsViewController.h"

@interface HNKDefinitionsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end

@implementation HNKDefinitionsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

#pragma mark - Setters

- (void)setWord:(NSString *)word
{
  _word = word;

  self.wordLabel.text = word;
}

@end
