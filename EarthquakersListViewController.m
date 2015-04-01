//
//  EarthquakersListViewController.m
//  Earthquakers
//
//  Created by A043TMEX on 28/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//


#import "EarthquakersListViewController.h"
#import "Earthquake.h"
#import "DetailViewController.h"

#define MAIN_SERVER @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

@implementation EarthquakersListViewController
{
    NSMutableArray *earthquakers;
    
}
@synthesize spinner;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data+
    UIBarButtonItem *opc1Item = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = opc1Item;
    
    connection = [[DataConnection alloc] init];
    [connection initPreferences:MAIN_SERVER];
    connection.connectionDelegate = self;
        spinner.hidesWhenStopped = YES;
     spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
  [connection createConnection];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:self.refreshControl];
    
   earthquakers = [[NSMutableArray alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [earthquakers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    //    UILabel *referenciaIDLabel = (UILabel *) [cell viewWithTag:233];
    
    Earthquake *myEarthquake = [earthquakers objectAtIndex:indexPath.row];
    
    cell.textLabel.text =    myEarthquake.place;
    cell.detailTextLabel.text = [NSString stringWithFormat: @"%.2f" , myEarthquake.magnitude];
    
    if(myEarthquake.magnitude>= 0 && myEarthquake.magnitude <=0.9)
        cell.backgroundColor = [UIColor greenColor];
    else if(myEarthquake.magnitude> 0.9 && myEarthquake.magnitude <=7.0)
        cell.backgroundColor = [UIColor orangeColor];
    else if(myEarthquake.magnitude>= 9.0 && myEarthquake.magnitude <=9.9)
        cell.backgroundColor = [UIColor redColor];
    
  /*  if (indexPath.row == [earthquakers count] - 1)
    {
        [connection createConnection];
    
    }*/
    
    return cell;
}



#pragma mark Delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Earthquake *selectedEarthquake = [earthquakers objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    DetailViewController  *vc = [storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    vc.strPlace =selectedEarthquake.place;
    vc.strMagnitude = selectedEarthquake.magnitude;
    vc.dateHour = selectedEarthquake.date;
    vc.latitud = selectedEarthquake.latitude;
    vc.longitud =selectedEarthquake.longitude;
    
    // vc.strUser = self.textUser.text;
    // vc.strUser = stringName;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)refresh:(id)sender
{
       [connection createConnection];
    NSLog(@"Refreshing");
}


#pragma mark -Connection Delegate

- (void)resultObtained:(NSData *)result{
    NSLog(@"Aqui");
    
     NSDictionary *dictionaryVals = [NSJSONSerialization JSONObjectWithData: result options: NSJSONReadingMutableContainers error: NULL];
    
    NSDictionary *list = [dictionaryVals valueForKey:@"features"] ;
    NSLog(@"%@ ", dictionaryVals);
    [earthquakers removeAllObjects];
    for(NSDictionary *hearthquake in list){
        NSDictionary *geometry = [hearthquake valueForKey:@"geometry"];
        NSDictionary *properties = [hearthquake valueForKey:@"properties"];
        NSArray *coordinates = [geometry valueForKey:@"coordinates"];
        
        Earthquake *myEarthquake = [[Earthquake alloc] init];
        myEarthquake.magnitude =[ [properties valueForKey:@"mag"] doubleValue];
        myEarthquake.place = [properties valueForKey:@"place"];
        NSTimeInterval _time = [[properties valueForKey:@"time"] doubleValue]/1000;
        myEarthquake.date =  [NSDate dateWithTimeIntervalSince1970:_time];
    
        myEarthquake.latitude =[ [coordinates objectAtIndex:1] doubleValue];
        myEarthquake.longitude = [ [coordinates objectAtIndex:0] doubleValue];
        [earthquakers addObject:myEarthquake];
    }
      [spinner stopAnimating];
    [self.refreshControl endRefreshing];
    [_tableResultados reloadData     ];
}

- (void)errorConnection:(NSError *)error{
    
    //TO DO, activate Timer to reload DATA
    
    [spinner stopAnimating];
   
    [[[UIAlertView alloc]initWithTitle:@"Error"
                               message:@"Ocurrio un error en la conexion."
                              delegate:self
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil, nil]show];
    
    
    
}



@end

