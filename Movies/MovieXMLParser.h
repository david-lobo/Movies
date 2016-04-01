//
//  MovieXMLParser.h
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieXMLParser : NSObject<NSXMLParserDelegate>
@property (strong, nonatomic) NSError *error;
@property BOOL success;
@property (strong, nonatomic) NSMutableArray *results;

- (id)initWithData:(NSData *)aData;
- (void)parse;
@end
