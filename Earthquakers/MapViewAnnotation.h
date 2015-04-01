//
//  MapViewAnnotacion.h
//  Earthquakers
//
//  Created by A043TMEX on 31/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject <MKAnnotation>
@property (nonatomic,copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate;

@end
