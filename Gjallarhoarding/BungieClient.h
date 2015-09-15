//
//  BungieClient.h
//  Gjallarhoarding
//
//  Created by Jordan Upham on 9/14/15.
//  Copyright © 2015 Jordan Upham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BungieClient : NSObject

+ (id)sharedInstance;
- (void)downloadItemManifest:(void (^)(NSURL *filePath, NSError *error))completion;

@end
