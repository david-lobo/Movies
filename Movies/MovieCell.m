//
//  MovieCell.m
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"

@interface MovieCell () {}
@end

@implementation MovieCell

- (void)configureCellForMovie:(Movie *)movie {
    
    self.titleLabel.text = movie.title;
}

@end
