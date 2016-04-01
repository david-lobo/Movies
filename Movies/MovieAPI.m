//
//  MovieAPI.m
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import "MovieAPI.h"
#import "Movie.h"
#import "MovieXMLParser.h"

static NSString *const MovieAPIRemoteURL = @"http://topstuffreview.com/webservice/test/newmovies.rss?x=2";

@interface MovieAPI () {
}

@property (nonatomic, copy) MovieAPIRemoteRequestCompleted finished;
@property NSMutableArray *movies;
@property MovieXMLParser *parser;
@end

@implementation MovieAPI

- (void)performRemoteRequest: (MovieAPIRemoteRequestCompleted) completionBlock {
    
    self.finished = completionBlock;
    self.movies = [[NSMutableArray alloc ] init];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    
    NSURL *remoteURL = [NSURL URLWithString: MovieAPIRemoteURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:remoteURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
                                      if (!error) {
                                          NSLog(@"Success");
                                          
                                          self.parser = [[MovieXMLParser alloc] initWithData:data];
                                          [self.parser parse];
                                          
                                          self.finished(self.parser.success, self.parser.results, self.parser.error);
                                          
                                      } else {
                                          NSLog(@"error: %@", [error localizedDescription]);
                                          self.finished(false, nil, error);
                                      }
                                  }];
    
    [task resume];
}

@end
