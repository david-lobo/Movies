//
//  Movie.h
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) UIImage *image;

@end
