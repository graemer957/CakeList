//
//  Cake.h
//  Cake List
//
//  Created by Graeme Read on 26/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface Cake : NSObject

@property (nonatomic, readonly, strong) NSString *title;
@property (nonatomic, readonly, strong) NSString *desc;
@property (nonatomic, readonly, strong) NSURL *image;

- (_Nullable instancetype)initFromDictionary:(NSDictionary<NSString *, NSString *> *)dictionary NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
