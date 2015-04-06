//
//  HNKHomeViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKHomeViewController.h"

@interface HNKHomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *definitionsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pronunciationsTextField;

@end

@implementation HNKHomeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

#pragma mark - IB Actions

- (IBAction)definitionsButtonTapped:(id)sender
{
  NSLog(@"Definitions Button Tapped");
}

- (IBAction)pronunciationsButtonTapped:(id)sender
{
  NSLog(@"Pronunciations Button Tapped");
}

- (IBAction)wordOfTheDayButtonTapped:(id)sender
{
  NSLog(@"Word of the Day Button Tapped");
}

- (IBAction)randomWordTapped:(id)sender
{
  NSLog(@"Random Word Tapped");
}

@end
