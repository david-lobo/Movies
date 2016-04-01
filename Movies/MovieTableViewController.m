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
@end

@implementation MovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNibs];
    
    //  Some Test code
    self.movieResults = [[NSMutableArray alloc] init];
    Movie *Movie1 = [[Movie alloc] init];
    Movie1.title = @"Of mice and men";
    [self.movieResults insertObject:Movie1 atIndex:0];
    
    Movie *Movie2 = [[Movie alloc] init];
    Movie2.title = @"And then there were none";
    [self.movieResults insertObject:Movie2 atIndex:1];
    
    Movie *Movie3 = [[Movie alloc] init];
    Movie3.title = @"The A Team";
    [self.movieResults insertObject:Movie3 atIndex:2];
    
    Movie *Movie4 = [[Movie alloc] init];
    Movie4.title = @"Over the rainbow";
    [self.movieResults insertObject:Movie4 atIndex:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier: MovieTableCellIdentifier forIndexPath: indexPath];
    
    Movie *movieData = (Movie *)self.movieResults[indexPath.row];
    
    [cell configureCellForMovie:movieData];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.movieResults count];
}

#pragma mark - Setup helpers

- (void)registerNibs {
    UINib *cellNib = [UINib nibWithNibName: MovieTableCellNib bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier: MovieTableCellIdentifier];
}

@end
