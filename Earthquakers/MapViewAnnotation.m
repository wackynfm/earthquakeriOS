//
//  MapViewAnnotacion.m
//  Earthquakers
//
//  Created by A043TMEX on 31/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

@synthesize coordinate=_coordinate;
@synthesize title=_title;
-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}

@end
