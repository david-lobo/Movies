//
//  MovieCell.m
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieCell () {}
@end

@implementation MovieCell

- (void)configureCellForMovie:(Movie *)movie {
    
    self.titleLabel.text = movie.title;
    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString: movie.imageURL] placeholderImage:[UIImage imageNamed:@"art_50"]];
}

@end
