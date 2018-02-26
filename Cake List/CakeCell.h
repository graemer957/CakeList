//
//  CakeCell.h
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CakeCell : UITableViewCell

@property (nonatomic, readwrite, weak) IBOutlet UIImageView *cakeImageView;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *descriptionLabel;

@end
