//
//  DEMOWordLookup.h
//  HNKWordLookup-Demo
//
//  Created by Harlan Kellaway on 4/7/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEMOWordLookup : NSObject

- (void)fetchDefinitionsForWord:(NSString *)word
                     completion:(void (^)(NSArray *, NSError *))completion;
- (void)fetchRandomWordWithCompletion:(void (^)(NSString *,
                                                NSError *))completion;
- (void)fetchWordOfTheDayWithCompletion:(void (^)(NSString *,
                                                  NSError *))completion;

@end
