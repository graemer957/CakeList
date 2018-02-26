//
//  Network.m
//  Cake List
//
//  Created by Graeme Read on 26/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "Network.h"
#import "Cake.h"


@interface Network ()

@property (nonatomic, readwrite, strong) NSURLSessionConfiguration *configuration;
@property (nonatomic, readwrite, strong) NSURLSession *session;

@end


@implementation Network

#pragma mark - Initialiser
- (instancetype)init {
    if (self = [super init]) {
        self.configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        self.configuration.URLCache = nil;
        self.configuration.timeoutIntervalForRequest = 10;
        
        self.session = [NSURLSession sessionWithConfiguration:self.configuration];
    }
    
    return self;
}

#pragma mark - Instance methods
- (void)getCakes:(void (^)(NSArray<Cake *> *_Nullable cakes, NSError *_Nullable error))completionHandler {
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    [self get:url completionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
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
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(cakes, nil);
        });
    }];
}

#pragma mark - Private methods
- (void)get:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completionHandler {
    [[self.session dataTaskWithURL:url
                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     if (error == nil) {
                         completionHandler(data, nil);
                     } else {
                         completionHandler(nil, error);
                     }
                 }] resume];
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
