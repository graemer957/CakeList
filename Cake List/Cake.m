//
//  Cake.m
//  Cake List
//
//  Created by Graeme Read on 26/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "Cake.h"


@interface Cake ()

@property (nonatomic, readwrite, strong) NSString *title;
@property (nonatomic, readwrite, strong) NSString *desc;
@property (nonatomic, readwrite, strong) NSURL *image;

@end


@implementation Cake

#pragma mark - Initialiser
- (_Nullable instancetype)initFromDictionary:(NSDictionary<NSString *, NSString *> *)dictionary {
    if (self = [super init]) {
        NSString *title = dictionary[@"title"];
        if (title == nil || title.length == 0) { return nil; }
        self.title = [title copy];
        
        NSString *desc = dictionary[@"desc"];
        if (desc == nil || desc.length == 0) { return nil; }
        self.desc = [desc copy];
        
        NSString *address = [dictionary[@"image"] stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        if (address == nil || address.length == 0) { return nil; }
        NSURL *url = [NSURL URLWithString:address];
        if (url == nil) { return nil; }
        self.image = url;
    }
    
    return self;
}

- (instancetype)init {
    return [self initFromDictionary:@{}];
}

@end
