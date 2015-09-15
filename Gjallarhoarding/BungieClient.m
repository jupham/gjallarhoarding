//
//  BungieClient.m
//  Gjallarhoarding
//
//  Created by Jordan Upham on 9/14/15.
//  Copyright © 2015 Jordan Upham. All rights reserved.
//

#import "AppDelegate.h"
#import "BungieClient.h"
#import "GHSessionManager.h"

@implementation BungieClient

static BungieClient *sharedInstance = nil;

+ (BungieClient *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (void)downloadItemManifest:(void (^)(NSURL *filePath, NSError *error))completion {
    [[GHSessionManager sharedInstance] getURLPath:@"Destiny/Manifest/" completion:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Error - %@", error);
            completion(nil, error);
            return;
        }
        NSDictionary *mobileWorldContentPaths = [response objectForKey:@"mobileWorldContentPaths"];
        if (!mobileWorldContentPaths) {
            NSLog(@"Error unable to find mobileWorldContentPaths in response");
            completion(nil, nil);
        }
        NSString *enContentPath = [mobileWorldContentPaths objectForKey:@"en"];
        if (!enContentPath) {
            NSLog(@"Error unable to find mobileWorldContentPaths in response");
            completion(nil, nil);
        }
        
        NSError *reqError = nil;
        AFHTTPSessionManager *session = [GHSessionManager sharedInstance];
        NSURL *downloadURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://bungie.net%@", enContentPath]];
        NSMutableURLRequest *request = [session.requestSerializer requestWithMethod:@"GET"
                                                                          URLString:downloadURL.absoluteString
                                                                         parameters:nil
                                                                              error:&reqError];
        id destination = ^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *dstPath = [[AppDelegate applicationDocumentsDirectory] URLByAppendingPathComponent:@"destinyitems.zip"];
            return dstPath;
        };
        
        id completion = ^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            NSLog(@"File Downloaded");
        };
        
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                                         progress:nil
                                                                      destination:destination
                                                                completionHandler:completion];
        [downloadTask resume];
    }];
}

@end
