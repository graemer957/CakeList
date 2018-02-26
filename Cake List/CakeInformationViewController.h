//
//  CakeInformationViewController.h
//  Cake List
//
//  Created by Graeme Read on 26/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cake;

NS_ASSUME_NONNULL_BEGIN
@interface CakeInformationViewController : UIViewController

@property (nonatomic, readwrite, strong) Cake *cake;

@end
NS_ASSUME_NONNULL_END
