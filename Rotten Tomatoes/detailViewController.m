//
//  detailViewController.m
//  Rotten Tomatoes
//
//  Created by Praveen Idiculla Mathews on 1/25/15.
//  Copyright (c) 2015 Praveen Idiculla Mathews. All rights reserved.
//

#import "detailViewController.h"
#import "MovieViewController.h"
#import "UIImageView+AFNetworking.h"


@interface detailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailedMovielabel;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *synopsisScrollView;

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *movieName = self.movie[@"title"];
    long movieYear = [self.movie[@"year"] integerValue];
    NSString *criticsScore = [self.movie valueForKeyPath:@"ratings.critics_score"];
    NSString *audienceScore = [self.movie valueForKeyPath:@"ratings.audience_score"];
    NSString *movieSynopsis =self.movie[@"synopsis"];

    NSString *movieHeading = [NSString stringWithFormat:@"%@ (%ld)",movieName,movieYear];
 
    //NSLog(movieName);
    //NSLog(@"%ld", movieYear);
    


    self.detailedMovielabel.text = movieHeading;
    self.ratingLabel.text = [NSString stringWithFormat:@"Critics Score: %@, Audience Score: %@",criticsScore,audienceScore];
    CGRect frame = CGRectMake(0.0,0.0, self.view.bounds.size.width, self.view.bounds.size.height);


    UITextView *myUITextView = [[UITextView alloc] initWithFrame:frame];
    myUITextView.text=movieSynopsis;
    myUITextView.font = [UIFont systemFontOfSize:13.0];
    myUITextView.textColor = [UIColor whiteColor];
    myUITextView.backgroundColor = [UIColor blackColor];
   
    self.synopsisScrollView.contentSize = CGSizeMake(320,500);
     [myUITextView sizeToFit];
    
    [self.synopsisScrollView addSubview:myUITextView];
    NSString *imageUrl = [self.movie valueForKeyPath:@"posters.thumbnail"] ;
    
    NSString *imageOrgUrl = [imageUrl stringByReplacingOccurrencesOfString:@"_tmb.jpg" withString:@"_org.jpg"];
    
    
    //NSLog(imageOrgUrl);

    [self.bannerImageView setImageWithURL:[NSURL URLWithString:imageOrgUrl]];
 
   //[self.bannerImageView setImageWithURL:[NSURL URLWithString:[self.movie valueForKeyPath:@"posters.thumbnail"]]];
   // NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=c9gxtwpcb9jcn8rw5qqszn8y&limit=20&country=us" ] ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
