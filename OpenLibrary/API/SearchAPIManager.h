//
//  SearchAPIManager.h
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/1/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import "APIManager.h"

typedef void(^searchSuccess)(NSArray* array);

@interface SearchAPIManager : APIManager

+ (SearchAPIManager *)sharedInstance;

- (void) searchBooksForKeyWord:(NSString *)keyWord byType:(NSString *)type withSuccess:(searchSuccess)success andFailure:(apiFailure)failure;

@end
