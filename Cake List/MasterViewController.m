//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeCell.h"
#import "Cake.h"
#import "Network.h"


@interface MasterViewController ()

@property (nonatomic, readwrite, copy) NSArray<Cake *> *cakes;

@end


@implementation MasterViewController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateCakes];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell *)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    
    Cake *cake = self.cakes[indexPath.row];
    cell.titleLabel.text = cake.title;
    cell.descriptionLabel.text = cake.desc;
    
    NSData *data = [NSData dataWithContentsOfURL:cake.image];
    UIImage *image = [UIImage imageWithData:data];
    cell.cakeImageView.image = image;
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Private methods
- (void)updateCakes {
    [[Network shared] getCakes:^(NSArray<Cake *> * _Nullable cakes, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"JSON Parse error: %@", error);
            return;
        }
        
        NSLog(@"Ingested %zd cakes, yummy...", cakes.count);
        self.cakes = cakes;
        [self.tableView reloadData];
    }];
}

@end
