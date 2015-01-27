//
//  MovieCell.h
//  Rotten Tomatoes
//
//  Created by Praveen Idiculla Mathews on 1/24/15.
//  Copyright (c) 2015 Praveen Idiculla Mathews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end