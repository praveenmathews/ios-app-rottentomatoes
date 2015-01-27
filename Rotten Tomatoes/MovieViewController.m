//
//  MovieViewController.m
//  Rotten Tomatoes
//
//  Created by Praveen Idiculla Mathews on 1/20/15.
//  Copyright (c) 2015 Praveen Idiculla Mathews. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "detailViewController.h"
#import "SVProgressHUD.h"

@interface MovieViewController() <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *movies ;
@property (nonatomic) NSArray *names ;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@end

@implementation MovieViewController

- (void) asyncNetworkCall {
    
    self.errorView.hidden =1;

    /* Asynchronous Call
     */
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=c9gxtwpcb9jcn8rw5qqszn8y&limit=10&country=us" ] ;
    NSURLRequest *request = [ NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            
            self.errorView.hidden =0 ;
            NSLog(@" %@" ,connectionError);
            
        }
        else{

            NSDictionary *responseDictionary =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil ];
            //        [SVProgressHUD dismiss];
            
            
            self.movies = (NSArray *) responseDictionary[@"movies"];
            [self.tableView reloadData ];
        }
        
        // NSLog(@" respone : %@",responseDictionary );
        
    }];
    
}

- (void)refresh:(id)sender {
    
    NSLog(@"Refreshing");
    
    [self asyncNetworkCall];
    
    // End Refreshing
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.names = @[ @"Tintu", @"Praveen", @"Preethi"];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
   [SVProgressHUD show];
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=c9gxtwpcb9jcn8rw5qqszn8y&limit=20&country=us" ] ;
    NSURLRequest *request = [ NSURLRequest requestWithURL:url];
    
    /* Synchorous Request 
     
    NSURLResponse *urlResponse = nil ;
    NSError *connectionError = nil ;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&connectionError ];
    
    
    NSDictionary *responseDictionary =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil ];
    NSLog(@" respone : %@",responseDictionary );
    self.movies = (NSArray *) responseDictionary[@"movies"];
    [self.tableView reloadData ];
    
    */
    
    /* Asynchronous Call
    */
    
     
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            [SVProgressHUD dismiss];
            self.errorView.hidden =0 ;
            NSLog(@" %@" ,connectionError);
        }
        else{
        NSDictionary *responseDictionary =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil ];
        
        // Adding a sleep to show progress
        //
        //[NSThread sleepForTimeInterval:1.0f];
        
        [SVProgressHUD dismiss];


        self.movies = (NSArray *) responseDictionary[@"movies"];
        [self.tableView reloadData ];
        }
       // NSLog(@" respone : %@",responseDictionary );
     
        
    }];

    

    
    self.tableView.dataSource= self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 110 ;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //   return 50;
    return self.movies.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    //cell.textLabel.text = self.names[indexPath.row];
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    //cell.textLabel.text= movie[@"title"];
    //cell.textLabel.text = [NSString stringWithFormat:@"Section: %ld , Row: %ld ",indexPath.section,indexPath.row];
    //NSLog(@"%@", [NSString stringWithFormat:@"Section: %ld , Row: %ld ",indexPath.section,indexPath.row]);
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]]];
     self.title = @"Rotten Tomatoes App";
    return  cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailViewController *vc = [[detailViewController alloc] init ];
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    vc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
