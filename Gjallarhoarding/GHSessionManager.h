//
//  GHSessionManager.h
//  Gjallarhoarding
//
//  Created by Jordan Upham on 9/14/15.
//  Copyright © 2015 Jordan Upham. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface GHSessionManager : AFHTTPSessionManager

+ (GHSessionManager *)sharedInstance;
- (void)getURLPath:(NSString *)path completion:(void (^)(NSDictionary *response, NSError *error))completion;

@end
