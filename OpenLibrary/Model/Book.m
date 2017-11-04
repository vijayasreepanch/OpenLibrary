//
//  Book.m
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/2/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import "Book.h"

@implementation Book

- (id) initWithBookDictionary:(NSDictionary *)bookDict;
{
    if (self = [super init]) {
        
        self.title = [bookDict valueForKey:@"title"];
        
        self.authorName = [[bookDict valueForKey:@"author_name"] objectAtIndex:0];
        
        self.isbn = [[bookDict valueForKey:@"isbn"] objectAtIndex:0];
    }
    
    return self;
}

@end
