//
//  Earthquake.m
//  Earthquakers
//
//  Created by A043TMEX on 28/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//

#import "Earthquake.h"

@implementation Earthquake

@synthesize longitude;
@synthesize latitude;
@synthesize magnitude;
@synthesize place;
@synthesize date;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.latitude = 0;
        self.longitude = 0;

    }
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.longitude = [[attributes valueForKeyPath:@"longitud"] doubleValue];
    self.latitude = [[attributes valueForKeyPath:@"latitud"] doubleValue];
  //  self.magnitude = [attributes valueForKey:@"magnitude"];
    self.place = [attributes valueForKey:@"place"];
    self.date = [attributes valueForKey:@"date"];
    
    
    return self;
}


@end
