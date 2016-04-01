//
//  MovieTableViewController.m
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import "MovieTableViewController.h"
#import "Movie.h"
#import "MovieCell.h"

static NSString *const MovieTableCellIdentifier = @"MovieCell";
static NSString *const MovieTableCellNib = @"MovieCell";

static NSString *const LoadingTableCellIdentifier = @"LoadingCell";
static NSString *const LoadingTableCellNib = @"LoadingCell";

@interface MovieTableViewController ()
@property NSMutableArray *movieResults;
@property BOOL isLoading;
@end

@implementation MovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    //self.isLoading = YES;
    
    [self registerNibs];
    
    //  Some Test code
    self.movieResults = [[NSMutableArray alloc] init];
    Movie *movie1 = [[Movie alloc] init];
    movie1.title = @"Of mice and men";
    movie1.imageURL = @"http://images.fandango.com/r100.0/ImageRenderer/111/168/images/no_image_111x168.jpg/188727/images/masterrepository/fandango/188727/godsnotdeadtwo.jpg";
    
    [self.movieResults insertObject:movie1 atIndex:0];
    
    Movie *movie2 = [[Movie alloc] init];
    movie2.title = @"And then there were none";
    [self.movieResults insertObject:movie2 atIndex:1];
    
    Movie *movie3 = [[Movie alloc] init];
    movie3.title = @"The A Team";
    [self.movieResults insertObject:movie3 atIndex:2];
    
    Movie *movie4 = [[Movie alloc] init];
    movie4.title = @"Over the rainbow";
    [self.movieResults insertObject:movie4 atIndex:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isLoading) {
        
        UITableViewCell *loadingCell = [self.tableView dequeueReusableCellWithIdentifier: LoadingTableCellIdentifier forIndexPath:indexPath];
        
        UIActivityIndicatorView *spinner = (UIActivityIndicatorView *)[loadingCell viewWithTag: 100];
        [spinner startAnimating];
        
        return loadingCell;
        
    } else {
    
        MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier: MovieTableCellIdentifier forIndexPath: indexPath];
        
        Movie *movieData = (Movie *)self.movieResults[indexPath.row];
        
        [cell configureCellForMovie:movieData];
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isLoading) {
        return 1;
    }
    
    return [self.movieResults count];
}

#pragma mark - Setup helpers

- (void)registerNibs {
    UINib *cellNib = [UINib nibWithNibName: MovieTableCellNib bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier: MovieTableCellIdentifier];
    
    UINib *loadingCellNib = [UINib nibWithNibName: LoadingTableCellNib bundle:nil];
    [self.tableView registerNib:loadingCellNib forCellReuseIdentifier: LoadingTableCellIdentifier];
}

@end
