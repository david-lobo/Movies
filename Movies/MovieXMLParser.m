//
//  MovieXMLParser.m
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import "MovieXMLParser.h"
#import "Movie.h"

@interface MovieXMLParser () {
}

@property NSData *data;
@property ()NSXMLParser *parser;
@property NSMutableDictionary *item;
@property NSMutableString *title;
@property NSMutableString *image;
@property NSString *element;
@end

@implementation MovieXMLParser

- (id)initWithData:(NSData *)data {
    if (self = [super init] ) {
        self.success = NO;
        self.error = nil;
        self.results = [[NSMutableArray alloc] init];
        
        self.data = data;
        self.parser = [[NSXMLParser alloc] initWithData:data];
        
        [self.parser setDelegate:self];
        [self.parser setShouldResolveExternalEntities:NO];
        
        return self;
    } else
        return nil;
}

- (void)parse {
    [self.parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    self.element = elementName;
    
    if ([self.element isEqualToString:@"item"]) {
        
        self.item    = [[NSMutableDictionary alloc] init];
        self.title   = [[NSMutableString alloc] init];
        self.image    = [[NSMutableString alloc] init];
    }
    
    if ([self.element isEqualToString:@"enclosure"]) {
        if ([attributeDict objectForKey: @"url"]) {
            [self.image appendString: attributeDict[@"url"]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([self.element isEqualToString:@"title"]) {
        [self.title appendString:string];
    } else if ([self.element isEqualToString:@"enclosure"]) {
        [self.image appendString: @"xx"];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [self.item setObject:self.title forKey:@"title"];
        [self.item setObject:self.image forKey:@"enclosure"];
        
        Movie *movie = [[Movie alloc] init];
        movie.title = self.title;
        movie.imageURL = self.image;
        
        [self.results addObject: movie];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    self.success = YES;
}

@end
