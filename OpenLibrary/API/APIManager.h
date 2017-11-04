//
//  APIManager.h
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/1/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^apiSuccess)(NSData *data, NSURLResponse *response);

typedef void(^apiFailure)(NSError *error);

@interface APIManager : NSObject

+ (APIManager *) sharedInstance;

- (void) sendHTTPGetRequestForURL:(NSString *)urlString withSuccess:(apiSuccess)success andFailure:(apiFailure)failure;

- (void) cancelRequest;

@end

