//
//  RestViewController.m
//  Earthquaker
//
//  Created by Nallely on 9/1/14.
//  Copyright (c) 2014  All rights reserved.
//

#import "Connection.h"

@implementation DataConnection

@synthesize connectionDelegate;
@synthesize done;
@synthesize status;
@synthesize urlConnection;
@synthesize strUrlConnection;
@synthesize webData;
@synthesize idThreadConnection;
@synthesize strMethodName;
@synthesize strSoapMessage;
@synthesize intTypeResult;
@synthesize reachability;

-(id) initWithId{
    
    NSLog(@"init:");
    
    
    if(self=[super init]){
        
    }
    return self;
}

-(void) initPreferences:(NSString*) strURL{
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    self.strUrlConnection = strURL;
    NSLog(@"La primer cadena es: %@", self.strUrlConnection);
}


-(void) killConnection {
    done = YES;
    NSError *error = [NSError errorWithDomain:@"HTTP" code:500 userInfo:nil];
    [self handleError:error];
}


- (id) setParameters:(NSString *) methodName : (NSDictionary *) dictionaryParameters {
       self.strMethodName = methodName;
        
       // [self initPreferences : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"WebService"]];
    
      [self consultar:dictionaryParameters];
        NSLog(@"El metodo es: %@", self.strMethodName);

    return self;
}


-(void)consultar:(NSDictionary *)parametros {
    
    self.strSoapMessage = [NSString stringWithFormat:
                           @"?%@", [self construirParametros:parametros]];
    NSLog(@"Send: %@",self.strSoapMessage);
    
}
-(NSString *) construirParametros:(NSDictionary *)parametros {
    NSString *resultado =@"";
    
    NSMutableDictionary *dictParametros =[[NSMutableDictionary alloc] initWithDictionary:parametros];
    
    for (NSString *key in dictParametros.allKeys) {
        NSString *param = [NSString stringWithFormat:@"%@=%@&", key,
                           [dictParametros objectForKey:key]];
        resultado = [resultado stringByAppendingString:param];
    }
    
    return resultado;
}


-(void) createConnection
{
    @synchronized(self){
        done = NO;
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        //NSString *urlText = [[NSString alloc] initWithFormat:@"%@/%@%@", self.strUrlConnection, self.strMethodName, self.strSoapMessage];
        
      //  NSLog(@"URL: %@", urlText);
        NSString *correctString = [ self.strUrlConnection stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
          NSLog(@"URL: %@", correctString);
        NSURL *url = [NSURL URLWithString: correctString];
        

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request addValue: @"text/xml charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"GET"];
        
        NSAssert(self.connectionDelegate, @"Error, delegate not set!");
        
        [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSLog(@"Con Exito");
                 if (self.connectionDelegate && [self.connectionDelegate respondsToSelector:@selector(resultObtained:)]) {
                     [connectionDelegate resultObtained:data];
                 }
                 
             } else {

                NSLog(@"Sin Exito");
                 if (self.connectionDelegate && [self.connectionDelegate respondsToSelector:@selector(errorConnection:)]) {
                     [connectionDelegate errorConnection:connectionError];
                 }
            }
         }];
    }
}

#pragma mark -
#pragma mark NSURLConnection delegate methods
-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"didReceiveResponse");

    [webData setLength:0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data{
    NSLog(@"didReceiveData");

    [webData appendData:data];
}

-(void) connection:(NSURLConnection*) connection didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");

    if([connectionDelegate respondsToSelector:@selector(errorConnection:)]){
        [connectionDelegate errorConnection:error];
    }
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    @synchronized(self){
        @try {
            NSString *theResult = [[NSString alloc] initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
            NSLog(@"XML: %@", theResult);
            
        /*    result =[[WebServiceResult alloc] init];
            if([theResult rangeOfString:@""].length > 0 || [theResult rangeOfString:@"s:Fault"].length > 0){
//                [result cargarError:]
                if([delegate respondsToSelector:@selector(errorSoap:)]){
                    [delegate errorSoap:(NSString *)result.resultado];
                }
            }else {
                [result cargarResultado:xmlDocument metodo:strMethodName tipoResultado:self.intTypeResult];
                if([delegate respondsToSelector:@selector(resultObtained: parameter:)])
                {
                    [delegate resultObtained:result.resultado parameter:[NSString stringWithFormat:@"%d", self.idThreadConnection]];
                }
            }*/
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
   }
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

-(void) handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}


-(BOOL) verifyConnectivity{
    NSLog(@"verifyConnectivty:");

    reachability= [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability  currentReachabilityStatus];
    NSLog(@"Network status: %ld", networkStatus);

    if(networkStatus == NotReachable){
        return NO;
    }else {
        return YES;
    }
}

@end
