//
//  GHSessionManager.m
//  Gjallarhoarding
//
//  Created by Jordan Upham on 9/14/15.
//  Copyright © 2015 Jordan Upham. All rights reserved.
//

#import "GHSessionManager.h"

@implementation GHSessionManager

static GHSessionManager *sharedInstance = nil;

+ (GHSessionManager *)sharedInstance {
    if (sharedInstance == nil) {
        NSURL *baseURL = [NSURL URLWithString:@"https://www.bungie.net/platform/"];
        sharedInstance = [[super allocWithZone:NULL] initWithBaseURL:baseURL];
    }
    
    return sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    
    if (self = [super initWithBaseURL:url]) {
        AFHTTPRequestSerializer *reqSerializer = [AFHTTPRequestSerializer serializer];
        [reqSerializer setValue:@"5a2e42cf9f43488b94e61bed413cdc92" forHTTPHeaderField:@"X-API-Key"];
        self.requestSerializer = reqSerializer;
    }
    
    return self;
}

- (void)getURLPath:(NSString *)path completion:(void (^)(NSDictionary *response, NSError *error))completion {
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Success");
        NSDictionary *response = [responseObject objectForKey:@"Response"];
        if (!response) {
            NSLog(@"Response Data Not Found");
        }
        completion(response, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error - %@", error);
        completion(nil, error);
    }];
}

@end
