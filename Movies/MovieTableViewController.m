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
#import "MovieAPI.h"

// Custom cell for movie data
static NSString *const MovieTableCellIdentifier = @"MovieCell";
static NSString *const MovieTableCellNib = @"MovieCell";

// Custom cell for loading message
static NSString *const LoadingTableCellIdentifier = @"LoadingCell";
static NSString *const LoadingTableCellNib = @"LoadingCell";

// Custom cell for no results message
static NSString *const EmptyTableCellIdentifier = @"EmptyCell";
static NSString *const EmptyTableCellNib = @"EmptyCell";

@interface MovieTableViewController ()
@property NSArray *movieResults;
@property BOOL isLoading;
@property MovieAPI *movieAPI;
@end

@implementation MovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.isLoading = YES;
    
    // Register custom UITableViewCells
    [self registerNibs];
    
    self.movieResults = [[NSMutableArray alloc] init];
    
    // Perform remote API data request
    [self refreshData];
    
    // Handle pull to refresh
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
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
        if ([self.movieResults count] == 0) {
            UITableViewCell *emptyCell = [self.tableView dequeueReusableCellWithIdentifier: EmptyTableCellIdentifier forIndexPath:indexPath];
            
            return emptyCell;
        }
    
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
    
    if (!self.movieResults || [self.movieResults count] == 0) {
        return 1;
    }
    
    return [self.movieResults count];
}

#pragma mark - Setup helpers

- (void)registerNibs {
    UINib *cellNib = [UINib nibWithNibName: MovieTableCellNib bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:MovieTableCellIdentifier];
    
    UINib *loadingCellNib = [UINib nibWithNibName: LoadingTableCellNib bundle:nil];
    [self.tableView registerNib:loadingCellNib forCellReuseIdentifier: LoadingTableCellIdentifier];
    
    UINib *emptyCellNib = [UINib nibWithNibName:EmptyTableCellNib bundle:nil];
    [self.tableView registerNib:emptyCellNib forCellReuseIdentifier: EmptyTableCellIdentifier];
}

#pragma mark - Loading data

- (void)refreshData {
    
    MovieAPIRemoteRequestCompleted completion = ^(BOOL success, NSMutableArray *results, NSError *error) {

        // Sort the results by title ignoring certain words
        NSArray *sortedResults = [results sortedArrayUsingComparator:^NSComparisonResult(Movie *movie1, Movie *movie2) {
        NSString *title1 = [self removePrefix:movie1.title];
        NSString *title2 = [self removePrefix:movie2.title];

        return [title1 compare:title2];
        }];
        
        self.movieResults = [sortedResults mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(self.refreshControl.refreshing) {
                [self.refreshControl endRefreshing];
            }
            if (!success) {
                if (error) {
                    [self showError:@"Error connectiing" withMessage:[error localizedDescription]];
                } else {
                    [self showError:@"Error connectiing" withMessage:@"Unknown problem"];
                }
            }
            
            self.isLoading = NO;
            [self.tableView reloadData];
        });
    };
    
    // Init the results array
    self.movieResults = [[NSArray alloc] init];
    
    // Init the api class
    self.movieAPI = [[MovieAPI alloc] init];
    
    // Perform the remote request to populate results
    [self.movieAPI performRemoteRequest: completion];
}

#pragma mark - Display helpers

- (void)showError:(NSString *)title withMessage:(NSString *)message {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
}

- (NSString*)removePrefix:(NSString *)fromString
{
    fromString = [fromString lowercaseString];
    NSRange range = NSMakeRange(NSNotFound, 0);
    if ([fromString hasPrefix:@"the "]) {
        range = [fromString rangeOfString:@"the "];
    } else if ([fromString hasPrefix:@"a "]) {
        range = [fromString rangeOfString:@"a "];
    } else if ([fromString hasPrefix:@"of "]) {
        range = [fromString rangeOfString:@"of "];
    }
    
    if (range.location != NSNotFound) {
        return [fromString substringFromIndex:range.length];
    } else {
        return fromString;
    }
}

@end
