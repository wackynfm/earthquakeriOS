//
//  ViewController.m
//  Earthquakers
//
//  Created by A043TMEX on 28/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//

#import "DetailViewController.h"
#import "MapViewAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>


#define METERS_PER_MILE 1609.344

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize latitud;
@synthesize longitud;
@synthesize strPlace;
@synthesize dateHour;
@synthesize strMagnitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lblPlace.text = [NSString stringWithFormat:@"In %@", strPlace, nil];
    self.lblMagnitude.text = [NSString stringWithFormat:@"Earthquake with magnitude %.2f",strMagnitude, nil];
    self.lblHour.text = [NSDateFormatter localizedStringFromDate:dateHour
                                                       dateStyle:NSDateFormatterShortStyle
                                                       timeStyle:NSDateFormatterFullStyle];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitud;
    zoomLocation.longitude= longitud;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 17.5*METERS_PER_MILE, 17.5*METERS_PER_MILE);
    
    CLLocationCoordinate2D coord;
    coord.latitude = latitud;
    coord.longitude = longitud;
    MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithTitle:@"Hearthquake" AndCoordinate:coord];
    
    [_mapView addAnnotation:annotation];
    [_mapView setRegion:viewRegion animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
