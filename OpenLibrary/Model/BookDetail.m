//
//  Book.m
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/2/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import "BookDetail.h"

@implementation BookDetail

- (id) initWithDictionary:(NSDictionary *)bookDetailDict;
{
    if (self = [super init])
    {
        self.bibKey = [bookDetailDict valueForKey:@"bib_key"];
        self.previewURL = [bookDetailDict valueForKey:@"preview_url"];
        self.thumbnailURL = [bookDetailDict valueForKey:@"thumbnail_url"];
    }
    
    return self;
}

@end
