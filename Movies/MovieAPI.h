//
//  MovieAPI.h
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieAPI : NSObject

typedef void (^MovieAPIRemoteRequestCompleted)(BOOL success, NSMutableArray *results, NSError *error);

- (void)performRemoteRequest: (MovieAPIRemoteRequestCompleted) completionBlock;

@end
