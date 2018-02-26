//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"

@implementation CakeCell

#pragma mark - UITableViewCell
- (void)prepareForReuse {
    [super prepareForReuse];
    self.url = nil;
}

@end
