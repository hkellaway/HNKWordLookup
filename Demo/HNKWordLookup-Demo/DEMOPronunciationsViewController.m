//
//  DEMOPronunciationsViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/7/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "DEMOPronunciationsTableViewCell.h"
#import "DEMOPronunciationsViewController.h"
#import <HNKWordLookup/HNKWordPronunciation.h>

static NSString *const kDemoPronunciationsPlaceholderText = @"Loading...";
static NSString *const kDemoPronunciationsCellReuseIdentifier =
    @"DemoPronunciationsCellReuseIdentifer";

@interface DEMOPronunciationsViewController () <UITableViewDataSource,
                                                UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITableView *pronunciationsTableView;

@end

@implementation DEMOPronunciationsViewController

#pragma mark - View life-cycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.wordLabel.text =
      self.word ? self.word : kDemoPronunciationsPlaceholderText;
}

#pragma mark - Setters

- (void)setPronunciations:(NSArray *)pronunciations
{
  _pronunciations = pronunciations;

  [self.pronunciationsTableView reloadData];

  //  self.activityIndicator.hidden = YES;
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
  return [self.pronunciations count];
}

- (UITableViewCell *)tableView:tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DEMOPronunciationsTableViewCell *cell = [tableView
      dequeueReusableCellWithIdentifier:kDemoPronunciationsCellReuseIdentifier];

  HNKWordPronunciation *pronunciation = self.pronunciations[indexPath.row];
  cell.pronunciationsLabel.text = pronunciation.pronunciationText;
  //  cell.attributionLabel.text = pronunciation.formatString;

  return cell;
}

@end
