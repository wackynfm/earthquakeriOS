//
//  Earthquake.h
//  Earthquakers
//
//  Created by A043TMEX on 28/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Earthquake : NSObject

@property (nonatomic, retain) NSString *place;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic) double magnitude;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
