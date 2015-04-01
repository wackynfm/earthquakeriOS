//
//  RestViewController.h
//  Earthquaker
//
//  Created by Nallely on 9/1/14.
//  Copyright (c) 2015  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

//#import "WebServiceResult.h"

@protocol ConnectionCallDelegate<NSObject>

@required

- (void)resultObtained:(NSData *)result;
- (void)errorConnection:(NSError *)error;

@end

@interface DataConnection : NSObject
{
    NSURLConnection *urlConnection;
    NSString * strUrlConnection;
    NSString * strMethodName;
    NSString * strMessage;
    
    int idThreadConnection;
    int intTypeResult;
    int cont;
    
    NSMutableData *webData;
    NSString *status;
    
    BOOL done;
     id <ConnectionCallDelegate> connectionDelegate;
  //  WebServiceResult * result;
    
    
}

@property(nonatomic, retain) NSURLConnection * urlConnection;
@property(nonatomic, retain) NSString * strUrlConnection;
@property(nonatomic, retain) NSString * strMethodName;
@property(nonatomic, retain) NSString * strSoapMessage;

@property(nonatomic, retain) NSMutableData * webData;
@property(nonatomic, retain) NSString * status;

@property BOOL done;
@property int idThreadConnection;
@property Reachability *reachability;
@property(nonatomic, assign) int intTypeResult;


@property(nonatomic,strong) id connectionDelegate;

- (id) initWithId;
- (void) initPreferences:(NSString*) strURL;
- (id)  setParameters:(NSString *) methodName : (NSDictionary *) dictionaryParameters ;
- (void) createConnection;
- (BOOL) verifyConnectivity;


@end


