//
//  MovieTableViewController.m
//  Movies
//
//  Created by david lobo on 01/04/2016.
//  Copyright © 2016 David Lobo. All rights reserved.
//

#import "MovieTableViewController.h"
#import "Movie.h"

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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
    

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: MovieTableCellIdentifier forIndexPath: indexPath];
    
    //NSDictionary *filmData = self.filmResults[indexPath.row];
    Movie *movieData = (Movie *)self.movieResults[indexPath.row];
    
    cell.textLabel.text = movieData.title;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.movieResults count];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
