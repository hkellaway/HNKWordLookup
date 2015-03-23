//
//  HNKDataSource.m
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/15/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKWordLookup.h"
#import "HNKHttpSessionManager.h"
#import "HNKWordDefinition.h"
#import "HNKWordOfTheDay.h"
#import "HNKWordPronunciation.h"

#import <Mantle/MTLJSONAdapter.h>

static NSString *const kBaseUrl = @"http://api.wordnik.com:80/v4";

@interface HNKWordLookup ()

@property (nonatomic, copy) NSString *apiKey;

@end

@implementation HNKWordLookup

#pragma mark - Initialization

static HNKWordLookup *sharedInstance = nil;

+ (instancetype)sharedInstanceWithAPIKey:(NSString *)apiKey
{
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] initWithAPIKey:apiKey];
	});

	return sharedInstance;
}

+ (instancetype)sharedInstance
{
	if (sharedInstance == nil) {
		NSAssert(FALSE, @"sharedInstance should not be called before sharedInstanceWithAPIKey");
	}

	return sharedInstance;
}

- (instancetype)initWithAPIKey:(NSString *)apiKey
{
	self = [super init];

	if (self) {
		self.apiKey = apiKey;

		NSURL *url = [NSURL URLWithString:kBaseUrl];
		[HNKHttpSessionManager setupSharedManager:url];
	}

	return self;
}

#pragma mark - Lookups

- (NSUInteger)definitionsForWord:(NSString *)word withCompletion:(void (^)(NSArray *, NSError *))completion
{
	return [HNKHttpSessionManager definitionsForWord:word apiKey:self.apiKey completion: ^(NSURLSessionDataTask *task,
	                                                                                       id responseObject,
	                                                                                       NSError *error) {
	                if(error) {
	                        completion(nil, error);
	                        return;
			}

	                NSError *parseError = nil;
	                NSArray *definitions = [self modelsOfClass:[HNKWordDefinition class] fromObjectNotation:responseObject error:&parseError];

	                if (parseError) {
	                        completion(nil, parseError);
	                        return;
			}
	                else {
	                        completion(definitions, nil);
			}
		}];
}

- (NSUInteger)definitionsForWord:(NSString *)word withPartsOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech completion:(void (^)(NSArray *, NSError *))completion
{
	return [self definitionsForWord:word withCompletion:^(NSArray *definitions, NSError *error) {
	                if(error) {
	                        completion(nil, error);
	                        return;
			}

	                completion([self definitions:definitions filteredByPartOfSpeech:partOfSpeech], nil);

		}];
}

- (NSUInteger)pronunciationsForWord:(NSString *)word completion:(void (^)(NSArray *, NSError *))completion
{
	return [HNKHttpSessionManager pronunciationsForWord:word apiKey:self.apiKey completion: ^(NSURLSessionDataTask *task,
	                                                                                          id responseObject,
	                                                                                          NSError *error) {
	                if(error) {
	                        completion(nil, error);
	                        return;
			}

	                NSError *parseError = nil;
	                NSArray *pronunciations = [self modelsOfClass:[HNKWordPronunciation class] fromObjectNotation:responseObject error:&parseError];

	                if (parseError) {
	                        completion(nil, parseError);
	                        return;
			}
	                else {
	                        completion(pronunciations, nil);
			}
		}];

}

- (NSUInteger)randomWordWithCompletion:(void (^)(NSString *, NSError *))completion
{
	return [HNKHttpSessionManager randomWordWithApiKey:self.apiKey completion: ^(NSURLSessionDataTask *task,
	                                                                             id responseObject,
	                                                                             NSError *error) {
	                if(error) {
	                        completion(nil, error);
	                        return;
			}

	                NSAssert([responseObject isKindOfClass:[NSDictionary class]],
	                         @"Random word object should be a dictionary");

	                NSString *randomWord = [responseObject valueForKey:@"word"];
	                completion(randomWord, nil);

		}];
}

- (NSUInteger)wordOfTheDayWithCompletion:(void (^)(HNKWordOfTheDay *, NSError *))completion
{
	return [self wordOfTheDayForDate:[NSDate date] completion:completion];
}

- (NSUInteger)wordOfTheDayForDate:(NSDate *)date completion:(void (^)(HNKWordOfTheDay *, NSError *))completion
{
	NSAssert(date <= [NSDate date], @"Provided date should not be in the future.");

	return [HNKHttpSessionManager wordOfTheDayForDate:date apiKey:self.apiKey completion: ^(NSURLSessionDataTask *task,
	                                                                                        id responseObject,
	                                                                                        NSError *error) {
	                if(error) {
	                        completion(nil, error);
	                        return;
			}

	                NSError *parseError = nil;
	                NSArray *modelsOfClass = [self modelsOfClass:[HNKWordOfTheDay class] fromObjectNotation:responseObject error:&parseError];

	                NSAssert([modelsOfClass count] == 1, @"Word of the Day should only return one object");

	                HNKWordOfTheDay *wordOfTheDay = (HNKWordOfTheDay *)[modelsOfClass objectAtIndex:0];

	                if (parseError) {
	                        completion(nil, parseError);
	                        return;
			}
	                else {
	                        completion(wordOfTheDay, nil);
			}

		}];
}

#pragma mark - Helpers

- (NSArray *)modelsOfClass:(Class)modelClass fromObjectNotation:(id)objectNotation error:(NSError **)error
{
	NSAssert([objectNotation isKindOfClass:[NSArray class]] || [objectNotation isKindOfClass:[NSDictionary class]],
	         @"Generic objects should be arrays or dictionaries");

	id parsedModelOfClass = nil;
	NSError *mantleError;

	if ([objectNotation isKindOfClass:[NSArray class]]) {
		parsedModelOfClass = [MTLJSONAdapter modelsOfClass:modelClass
		                      fromJSONArray:objectNotation
		                      error:&mantleError];
	}
	else if ([objectNotation isKindOfClass:[NSDictionary class]]) {
		parsedModelOfClass = [MTLJSONAdapter modelOfClass:modelClass
		                      fromJSONDictionary:objectNotation
		                      error:&mantleError];
	}

	if(mantleError) {
		*error = mantleError;
		return nil;
	} else {
		if(![parsedModelOfClass isKindOfClass:[NSArray class]]) {
			return [NSArray arrayWithObject:parsedModelOfClass];
		}

		return parsedModelOfClass;
	}
}

- (NSArray *)definitions:(NSArray *)definitions filteredByPartOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech
{
	NSMutableArray *filteredDefinitions = [NSMutableArray array];

	for(HNKWordDefinition *definition in definitions) {
		if([self isDefinition:definition partOfSpeech:partOfSpeech]) {
			[filteredDefinitions addObject:definition];
		}
	}

	return [filteredDefinitions copy];
}

- (BOOL)isDefinition:(HNKWordDefinition *)definition partOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech
{
	for(int p = HNKWordDefinitionPartOfSpeechAbbreviation; p <= HNKWordDefinitionPartOfSpeechVerbTransitive; p *= 2) {
		if([self isPartOfSpeech:p includedIn:partOfSpeech]) {
			if(definition.partOfSpeech == p) {
				return YES;
			}
		}
	}

	return NO;
}

- (BOOL)isPartOfSpeech:(HNKWordDefinitionPartOfSpeech)partOfSpeech includedIn:(HNKWordDefinitionPartOfSpeech)partOfSpeechList
{
	return (partOfSpeech | partOfSpeechList) == partOfSpeechList;
}

@end
