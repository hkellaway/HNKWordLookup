//
//  HNKWordOfTheDay.h
//  HNKWordLookup
//
//  Created by Harlan Kellaway on 3/19/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import <Mantle/Mantle.h>

@class HNKWordDefinition;

@interface HNKWordOfTheDay : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSDate *datePublished;

@end
