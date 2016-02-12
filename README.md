# HNKWordLookup

[![CocoaPods](https://img.shields.io/cocoapods/v/HNKWordLookup.svg)](http://cocoapods.org/pods/HNKWordLookup)
![Objective-C](https://img.shields.io/badge/language-objective--c-blue.svg)
[![CocoaPods](https://img.shields.io/cocoapods/l/HNKWordLookup.svg)](https://raw.githubusercontent.com/hkellaway/HNKWordLookup/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/p/HNKWordLookup.svg)](http://cocoapods.org/pods/HNKWordLookup)
[![Build Status](https://travis-ci.org/hkellaway/HNKWordLookup.svg?branch=master)](https://travis-ci.org/hkellaway/HNKWordLookup)

HNKWordLookup is a Cocoapod that performs standard English-language dictionary queries, such as definitions, pronunciations, random words, and Word of the Day.

<img src="https://raw.githubusercontent.com/hkellaway/HNKWordLookup/develop/Demo/demo.gif" title="demo gif" height="600" />

## Communication

- If you **have found a bug**, _and can provide steps to reliably reproduce it_, [open an issue](https://github.com/hkellaway/HNKWordLookup/issues/new).
- If you **have a feature request**, [open an issue](https://github.com/hkellaway/HNKWordLookup/issues/new).
- If you **want to contribute**, [submit a pull request](https://github.com/hkellaway/HNKWordLookup/pulls).

## Getting Started

- [Download HNKWordLookup](https://github.com/hkellaway/HNKWordLookup/archive/master.zip) and try out the included iOS example app
- Check out the [documentation](http://cocoadocs.org/docsets/HNKWordLookup/) for a more comprehensive look at the classes available in HNKWordLookup

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like HNKWordLookup in your projects. CocoaPods is the preferred way to incorporate HNKWordLookup in your project; if you are unfamiliar with how to install CocoaPods or how create a Podfile, there are many tutorials online.

#### Podfile

```ruby
platform :ios, '7.0'
pod "HNKWordLookup", "~> 1.1"
```

### API Key

HNKWordLookup uses the [Wordnik API](http://developer.wordnik.com/docs.html) to lookup information. You will need a Wordnik API key in order to use HNKWordLookup.

* Create a [Wordnik](https://www.wordnik.com/signup) account
* Once activated, find your API key on your [Settings](https://www.wordnik.com/users/edit) page

## Classes

- `HNKLookup`
- `HNKWordDefinition`
- `HNKWordPronunciation`
- `HNKWordOfTheDay`

## Usage

### Setup

Requests cannot be made without first supplying `HNKLookup` with your Wordnik API Key (see [Getting Started](#getting-started)). Once your API key is obtained, you can setup `HNKLookup` for use by calling `sharedInstanceWithAPIKey` (typically within the `AppDelegate`):

```objective-c
[HNKLookup sharedInstanceWithAPIKey:@"YOUR_API_KEY"];
```

You should replace `YOUR_API_KEY` with your Wordnik API key.

### Lookups

`HNKLookup` is responsible for handling any lookups of information. Once [Setup](#setup) is complete, lookup requests can be made to `[HNKLookup sharedInstance]`.

#### Looking up `definitions`

```objective-c
[[HNKLookup sharedInstance] definitionsForWord:@"center" completion:^(NSArray *definitions, NSError *error) {
    if (error) {
        NSLog(@"ERROR: %@", error);
    } else {
        for (HNKWordDefinition *definition in definitions) {
	        NSLog(@"%@", definition);
		}
    }
}];
```

#### Looking up `definitions` with specific `partsOfSpeech`

Note: The `partsOfSpeech` argument can take any number of `HNKWordDefinitionPartOfSpeech` types separated by a `|` symbol.

```objective-c
[[HNKLookup sharedInstance] definitionsForWord:@"center" 
                                 withPartsOfSpeech:HNKWordDefinitionPartOfSpeechNoun | HNKWordDefinitionPartOfSpeechVerbTransitive
                                        completion:^(NSArray *definitions, NSError *error) {
    if (error) {
        NSLog(@"ERROR: %@", error);
    } else {
        for (HNKWordDefinition *definition in definitions) {
	        NSLog(@"%@", definition);
		}
    }
}];
```

#### Looking up `pronunciations`

```objective-c
[[HNKLookup sharedInstance] pronunciationsForWord:@"orange" completion:^(NSArray *pronunciations, NSError *error) {
    if (error) {
        NSLog(@"ERROR: %@", error);
    } else {
        for (HNKWordPronunciation *pronunciation in pronunciations) {
	        NSLog(@"%@", pronunciation);
		}
    }
}];
```

#### Looking up a random word

```objective-c
[[HNKLookup sharedInstance] randomWordWithCompletion:^(NSString *randomWord, NSError *error) {
    if (error) {
        NSLog(@"ERROR: %@", error);
    } else {
	    NSLog(@"%@", randomWord);
    }
}];
```

#### Looking up the `wordOfTheDay`

```objective-c
[[HNKLookup sharedInstance] wordOfTheDayWithCompletion:^(HNKWordOfTheDay *wordOfTheDay, NSError *error) {
    if (error) {
        NSLog(@"ERROR: %@", error);
    } else {
		NSLog(@"%@", wordOfTheDay);
    }
}];
```

#### Looking up the `wordOfTheDay` for a specific `date`

```objective-c
[[HNKLookup sharedInstance] wordOfTheDayForDate:[NSDate date] completion:^(HNKWordOfTheDay *wordOfTheDay, NSError *error) {
    if (error) {
        NSLog(@"ERROR: %@", error);
    } else {
		NSLog(@"%@", wordOfTheDay);
    }
}];
```

## Delegate Methods

Delegate methods are available to classes that implement the `HNKLookupDelegate` protocol.

#### Optional Delegate Methods

##### `(BOOL)shouldDisplayNetworkActivityIndicator`

The return value of this method determines whether the activity indicator in the status bar is displayed while `HNKLookup` makes network requests. The default is `NO`.

To have the activity indicator displayed, the class that implements the `HNKLookupDelegate` protocol should include the following method call:

```objective-c
- (BOOL)shouldDisplayNetworkActivityIndicator {
  return YES;
}
```

## Credits

HNKWordLookup was created by [Harlan Kellaway](http://harlankellaway.com) and uses the [Wordnik API](http://developer.wordnik.com/docs.html).

## License

HNKWordLookup is available under the MIT license. See the [LICENSE](https://raw.githubusercontent.com/hkellaway/HNKWordLookup/master/LICENSE) file for more info.
