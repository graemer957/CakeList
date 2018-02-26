//
//  Network.m
//  Cake List
//
//  Created by Graeme Read on 26/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "Network.h"
#import "Cake.h"

@implementation Network

#pragma mark - Instance methods
- (void)getCakes:(void (^)(NSArray<Cake *> *_Nullable cakes, NSError *_Nullable error))completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSError *jsonError;
    id responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
    if (jsonError) {
        completionHandler(nil, jsonError);
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
    completionHandler(cakes, nil);
}

#pragma mark - Singleton methods
// See https://stackoverflow.com/questions/7568935/how-do-i-implement-an-objective-c-singleton-that-is-compatible-with-arc
+ (Network *)shared {
    static Network *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[Network alloc] init];
    });
    
    return shared;
}

@end
