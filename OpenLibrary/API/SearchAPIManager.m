//
//  SearchAPIManager.m
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/1/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import "SearchAPIManager.h"
#import "Book.h"

@implementation SearchAPIManager

+ (SearchAPIManager *)sharedInstance;
{
    static SearchAPIManager *searchAPIManager;
    
    static dispatch_once_t dispatchOnce;
    
    dispatch_once(&dispatchOnce, ^{
        
        searchAPIManager = [SearchAPIManager new];
    });
    
    return searchAPIManager;
}

- (void) searchBooksForKeyWord:(NSString *)keyWord byType:(NSString *)type withSuccess:(searchSuccess)success andFailure:(apiFailure)failure;
{
    NSString *searchAPIurlString = [NSString stringWithFormat:@"http://openlibrary.org/search.json?%@=%@", type, keyWord];
    
    [self sendHTTPGetRequestForURL:searchAPIurlString withSuccess:^(NSData *data, NSURLResponse *response) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableArray *booksArray = [NSMutableArray new];
        
        for (NSDictionary * bookDictionary in [jsonDictionary objectForKey:@"docs"])
        {
            Book *book = [[Book alloc] initWithBookDictionary:bookDictionary];
            
            [booksArray addObject:book];
        }
        
        success(booksArray);
        
    } andFailure:^(NSError *error) {
        
        failure (error);
        
    }];
}



@end
