//
//  ViewController.m
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 3/22/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "ViewController.h"

#import <HNKWordLookup/HNKWordLookup.h>

static NSString *const kHNKApiKey = @"6c178ad0c2380bea5f47519d6924aade3522e60a23fa51db1";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[HNKLookup sharedInstanceWithAPIKey:kHNKApiKey];

	[[HNKLookup sharedInstance] definitionsForWord:@"center" withCompletion: ^(NSArray *definitions, NSError *error) {
	    if (error) {
	        NSLog(@"ERROR: %@", error);
		}
	    else {
	        NSLog(@"%li DEFINITIONS:", (long)[definitions count]);

	        for (HNKWordDefinition *definition in definitions) {
	            NSLog(@"%@", definition);
			}
		}
	}
	];

	[[HNKLookup sharedInstance] definitionsForWord:@"center"
	                             withPartsOfSpeech:HNKWordDefinitionPartOfSpeechNoun | HNKWordDefinitionPartOfSpeechVerbTransitive
	                                    completion: ^(NSArray *definitions, NSError *error) {
	    if (error) {
	        NSLog(@"ERROR: %@", error);
		}
	    else {
	        NSLog(@"%li DEFINITIONS WITH PART OF SPEECH:", (long)[definitions count]);

	        for (HNKWordDefinition *definition in definitions) {
	            NSLog(@"%@", definition.partOfSpeechString);
			}
		}
	}];

	[[HNKLookup sharedInstance] pronunciationsForWord:@"orange" completion: ^(NSArray *pronunciations, NSError *error) {
	    if (error) {
	        NSLog(@"ERROR: %@", error);
		}
	    else {
	        NSLog(@"PRONUNCIATIONS:");

	        for (HNKWordPronunciation *pronunciation in pronunciations) {
	            NSLog(@"%@", pronunciation.pronunciationText);
			}
		}
	}];

	[[HNKLookup sharedInstance] wordOfTheDayWithCompletion: ^(HNKWordOfTheDay *wordOfTheDay, NSError *error) {
	    if (error) {
	        NSLog(@"ERROR: %@", error);
		}
	    else {
	        NSLog(@"WORD OF THE DAY: %@ %@", wordOfTheDay.word, wordOfTheDay.datePublished);
		}
	}];

	[[HNKLookup sharedInstance] wordOfTheDayForDate:[NSDate hnk_dateFromString:@"2015-03-01T00:00:00.000+0000"] completion: ^(HNKWordOfTheDay *wordOfTheDay, NSError *error) {
	    if (error) {
	        NSLog(@"ERROR: %@", error);
		}
	    else {
	        NSLog(@"WORD OF THE DAY: %@ %@", wordOfTheDay.word, wordOfTheDay.datePublished);
		}
	}];


	[[HNKLookup sharedInstance] randomWordWithCompletion: ^(NSString *randomWord, NSError *error) {
	    if (error) {
	        NSLog(@"ERROR: %@", error);
		}
	    else {
	        NSLog(@"RANDOM WORD: %@", randomWord);
		}
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
