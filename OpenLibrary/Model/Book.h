//
//  Book.h
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/2/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* authorName;
@property (nonatomic, strong) NSString* isbn;

- (id) initWithBookDictionary:(NSDictionary *)bookDict;

@end
