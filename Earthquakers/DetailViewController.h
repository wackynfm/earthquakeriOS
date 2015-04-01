//
//  ViewController.h
//  Earthquakers
//
//  Created by A043TMEX on 28/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface DetailViewController : UIViewController

@property (nonatomic) double latitud;
@property (nonatomic) double longitud;
@property (nonatomic,strong) NSString *strPlace;
@property (nonatomic,strong) NSDate *dateHour;
@property (nonatomic) double strMagnitude;

@property (nonatomic, strong) IBOutlet UILabel *lblPlace;
@property (nonatomic, strong) IBOutlet UILabel *lblHour;
@property (nonatomic, strong) IBOutlet UILabel *lblMagnitude;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end

