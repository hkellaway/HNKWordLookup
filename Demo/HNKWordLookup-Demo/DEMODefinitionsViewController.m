//
//  DEMODefinitionsViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/5/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "DEMODefinitionsViewController.h"

static NSString *const kDemoPlaceholderText = @"Loading...";
static NSString *const kDemoCellReuseIdentifier = @"DemoCellReuseIdentifer";

@interface DEMODefinitionsViewController () <UITableViewDataSource,
                                             UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *definitionsTableView;

@end

@implementation DEMODefinitionsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.wordLabel.text = self.word ? self.word : kDemoPlaceholderText;
}

#pragma mark - Setters

- (void)setDefinitions:(NSArray *)definitions
{
  _definitions = definitions;

  [self.definitionsTableView reloadData];

  self.activityIndicator.hidden = YES;
}

- (void)setWord:(NSString *)word
{
  _word = word;

  self.wordLabel.text = word;
}

#pragma mark - Protocol conformance
#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
  return self.definitions.count;
}

- (UITableViewCell *)tableView:tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:kDemoCellReuseIdentifier];

  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:kDemoCellReuseIdentifier];
  }

  cell.textLabel.text = @"definition";

  return cell;
}

@end
