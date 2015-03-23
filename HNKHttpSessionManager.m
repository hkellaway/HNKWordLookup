//
//  HNKHttpSessionManager.m
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/14/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "HNKHttpSessionManager.h"

#import "NSDate+HNKAdditions.h"

#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#pragma mark - Constants

static NSString * const kHNKPathDefinitions = @"word.json/%@/definitions";
static NSString * const kHNKPathPronunciations = @"word.json/%@/pronunciations";
static NSString * const kHNKPathRandomWord = @"words.json/randomWord";
static NSString * const kHNKPathWordOfTheDay = @"words.json/wordOfTheDay";

@implementation HNKHttpSessionManager

#pragma mark - Initialization

+ (void)setupSharedManager:(NSURL *)url
{
	[self sharedManagerWithURL:url];
	[[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

+ (instancetype)sharedManagerWithURL:(NSURL *)url
{
	static HNKHttpSessionManager *manager = nil;
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		NSAssert(url, @"A valid url should be provided");

		manager = [[self alloc] initWithBaseURL:url];

		AFJSONResponseSerializer *responseSerializer = [[AFJSONResponseSerializer alloc] init];
		responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

		manager.responseSerializer = responseSerializer;
		manager.requestSerializer = [AFJSONRequestSerializer serializer];

	});

	return manager;
}

+(instancetype)sharedManager
{
	return [self sharedManagerWithURL : nil];
}

#pragma mark - Class methods

#pragma mark Requests

+ (NSUInteger)definitionsForWord:(NSString *)word apiKey:(NSString *)apiKey completion:(void (^)(NSURLSessionDataTask *, id, NSError *))completion
{
	return [self startRequestWithPath:[NSString stringWithFormat:kHNKPathDefinitions, word]
	        parameters:@{ @"api_key" : apiKey }
	        completion:completion];
}

+ (NSUInteger)pronunciationsForWord:(NSString *)word apiKey:(NSString *)apiKey completion:(void (^)(NSURLSessionDataTask *, id, NSError *))completion
{
	return [self startRequestWithPath:[NSString stringWithFormat:kHNKPathPronunciations, word]
	        parameters:@{ @"api_key" : apiKey }
	        completion:completion];
}

+ (NSUInteger)randomWordWithApiKey:(NSString *)apiKey completion:(void (^)(NSURLSessionDataTask *, id, NSError *))completion
{
	return [self startRequestWithPath : kHNKPathRandomWord
	        parameters : @{
	                @"hasDictionaryDef" : @"true",
	                @"minCorpusCount" : @(0),
	                @"maxCorpusCount" : @(-1),
	                @"minDictionaryCount" : @(1),
	                @"maxDictionaryCount" : @(-1),
	                @"minLength" : @(3),
	                @"maxLength" : @(-1),
	                @"api_key" : apiKey
		}
	        completion:completion];
}

+ (NSUInteger)wordOfTheDayForDate:(NSDate *)date apiKey:(NSString *)apiKey completion:(void (^)(NSURLSessionDataTask *, id, NSError *))completion
{
	int day = (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date] day];
	int month = (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date] month];
	int year = (int)[[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date] year];

	NSString *dateString = [NSDate hnk_stringFromDateWithYear:year month:month day:day];

	return [self startRequestWithPath:kHNKPathWordOfTheDay
	        parameters:@{
	                @"date" : dateString,
	                @"api_key" : apiKey
		}
	        completion:completion];
}

#pragma mark - Helper methods

+ (NSUInteger)startRequestWithPath:(NSString *)path
        parameters:(id)parameter
        completion:( void (^)(NSURLSessionDataTask *task,
                              id responseObject,
                              NSError *error) )completion
{
	HNKHttpSessionManager *manager = [HNKHttpSessionManager sharedManager];
	NSURLSessionDataTask *newTask = nil;

	void (^success)(NSURLSessionDataTask *, id);
	success = ^(NSURLSessionDataTask *task, id responseObject) {
		completion(task, responseObject, nil);
	};

	void (^failure)(NSURLSessionDataTask *, NSError *);
	failure = ^(NSURLSessionDataTask *task, NSError *error) {
		completion(task, nil, error);
	};

	NSString *fullPath = [[manager.baseURL absoluteString] stringByAppendingPathComponent:path];
	newTask = [manager GET:fullPath parameters:parameter success:success failure:failure];

	return newTask.taskIdentifier;
}

@end
