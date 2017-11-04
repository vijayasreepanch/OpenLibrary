//
//  APIManager.m
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/1/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import "APIManager.h"

@interface APIManager () <NSURLSessionDelegate>

@end

@implementation APIManager
{
    NSURLSessionDataTask *_getTask;
}


+ (APIManager *) sharedInstance;
{
    static APIManager *apiManager;
    static dispatch_once_t dispatchOnce;
    
    _dispatch_once(&dispatchOnce, ^{
        
        apiManager = [APIManager new];
    });
    
    return apiManager;
}

//method for get request
- (void) sendHTTPGetRequestForURL:(NSString *)urlString withSuccess:(apiSuccess)success andFailure:(apiFailure)failure;
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    _getTask = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        if (error == nil)
        {
            success (data, response);
        }
        else
        {
            failure (error);
        }
    }];
    
    [_getTask resume];
}

- (void) cancelRequest;
{
    [_getTask suspend];
}
@end
