//
//  CakeInformationViewController.m
//  Cake List
//
//  Created by Graeme Read on 26/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "CakeInformationViewController.h"
#import "Cake.h"
#import "Network.h"

@interface CakeInformationViewController ()

@property (nonatomic, readwrite, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, readwrite, weak) IBOutlet UILabel *descLabel;

@end


@implementation CakeInformationViewController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Due to bug in Xcode 9.2, setting in IB will render offscreen
    self.titleLabel.numberOfLines = 0;
    self.descLabel.numberOfLines = 0;
    
    [[Network shared] getImageFrom:self.cake.image completionHandler:^(UIImage * _Nullable image) {
        self.imageView.image = image;
    }];
    self.titleLabel.text = self.cake.title;
    self.descLabel.text = self.cake.desc;
}

@end
