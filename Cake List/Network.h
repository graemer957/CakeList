//
//  Network.h
//  Cake List
//
//  Created by Graeme Read on 26/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cake;

NS_ASSUME_NONNULL_BEGIN
@interface Network : NSObject

- (void)getCakes:(void (^)(NSArray<Cake *> *_Nullable cakes, NSError *_Nullable error))completionHandler;

#pragma mark - Class methods
+ (Network *)shared;

@end
NS_ASSUME_NONNULL_END
