//
//  Book.h
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/2/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookDetail : NSObject

@property (nonatomic, strong) NSString *bibKey;

@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) NSString *previewURL;
@property (nonatomic, strong) NSString *infoURL;

- (id) initWithDictionary:(NSDictionary *)bookDetailDict;

@end
