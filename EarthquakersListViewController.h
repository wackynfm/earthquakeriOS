//
//  EarthquakersListViewController.h
//  Earthquakers
//
//  Created by A043TMEX on 28/03/15.
//  Copyright (c) 2015 A043TMEX. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Connection.h"

@interface EarthquakersListViewController : UITableViewController <ConnectionCallDelegate>
{
    DataConnection *connection;
    UIRefreshControl*refreshControl;

}

@property(weak, nonatomic) IBOutlet UITableView *tableResultados;
@property (nonatomic,strong)  UIActivityIndicatorView *spinner ;

@end
