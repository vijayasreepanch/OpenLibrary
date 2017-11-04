//
//  BookTableViewCell.h
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/2/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *author;

@end
