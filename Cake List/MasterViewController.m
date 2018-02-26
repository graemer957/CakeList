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


@interface MasterViewController ()

@property (nonatomic, readwrite, strong) NSMutableArray<Cake *> *cakes;

@end


@implementation MasterViewController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
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
- (void)getData {
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *jsonError;
    id responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parse error");
        return;
    }
    
    NSMutableArray<Cake *> *cakes = [@[] mutableCopy];
    if ([responseData isKindOfClass:[NSArray class]]) {
        NSArray *cakeDictionaries = (NSArray *)responseData;
        for (id object in cakeDictionaries) {
            if ([object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *cakeDictionary = (NSDictionary *)object;
                Cake *cake = [[Cake alloc] initFromDictionary:cakeDictionary];
                if (cake != nil) {
                    [cakes addObject:cake];
                }
            }
        }
    }
    NSLog(@"Ingested %zd cakes, yummy...", cakes.count);
    self.cakes = cakes;
    [self.tableView reloadData];
}

@end
