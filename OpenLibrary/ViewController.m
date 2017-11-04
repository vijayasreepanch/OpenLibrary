//
//  ViewController.m
//  OpenLibrary
//
//  Created by Vijayasree Panchapakesan on 11/1/17.
//  Copyright © 2017 Vijayasree Panchapakesan. All rights reserved.
//

#import "ViewController.h"
#import "SearchAPIManager.h"
#import "BookTableViewCell.h"
#import "Book.h"

@interface ViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController
{
    __weak IBOutlet UISearchBar *_searchBar;
    
    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UISegmentedControl *_segmentedControl;
    
    NSInteger counter1;
    
    NSInteger counter2;
    
    NSString* searchKeyWord;
    
    NSMutableArray *_booksArray;
    
    SearchByType searchByType;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_tableView registerNib:[UINib nibWithNibName:@"BookTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"bookTableViewCellIdentifier"];
    
    _searchBar.delegate = self;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) searchBooksForKeyWord:(NSString *)keyWord
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *searchByTypeString;
    
    if (searchByType == author) {
        searchByTypeString = @"author";
    }
    else
    {
        searchByTypeString = @"title";
    }
    
    if (keyWord.length > 0)
    {
        [[SearchAPIManager sharedInstance] searchBooksForKeyWord:[keyWord stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]] byType:searchByTypeString withSuccess:^(NSArray *array) {
            
            if (array.count == 0 )
            {
                _booksArray = [NSMutableArray arrayWithCapacity: 1];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    [_booksArray addObject: [_tableView dequeueReusableCellWithIdentifier: @"noResultCellResuseIdentifier"]];
                });
            }
            else
            {
                _booksArray = [NSMutableArray arrayWithArray:array];
            }
            
            [self updateTableView];
            
        } andFailure:^(NSError *error) {
            
            //TODO: Present error to user.
            NSLog(@"API Failure");
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }];
    }
    else
    {
        _booksArray = nil;
        
        [self updateTableView];
    }
    
}

- (void) updateTableView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    });
}
- (IBAction)authorTitleSelectionChanged:(id)sender {
    
    UISegmentedControl *s = (UISegmentedControl *)sender;
    
    if (s.selectedSegmentIndex == 0) {
        searchByType = title;
    }
    else
    {
        searchByType = author;
    }
    
    [self searchBooksForKeyWord:searchKeyWord];
}

#pragma tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_booksArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_booksArray objectAtIndex:indexPath.row] isKindOfClass:[UITableViewCell class]])
    {
        return ((UITableViewCell *)[_booksArray objectAtIndex:indexPath.row]);
    }
    
    
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookTableViewCellIdentifier"];
    
    cell.selectionStyle = UITableViewStylePlain;
    
    if (_booksArray.count > 0)
    {
        Book *book = [_booksArray objectAtIndex:indexPath.row];
        
        cell.title.text = book.title;
        cell.author.text = book.authorName;
    }
    
    return cell;
}
    


#pragma mark - Search Bar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    counter1 +=1;
    
    searchKeyWord = searchText;
    
    [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(beginSearch) userInfo:nil repeats:NO];
    
}

- (void) beginSearch
{
    counter2 += 1;
    
    if (counter1 == counter2)
    {
        [self searchBooksForKeyWord:searchKeyWord];
    }
}


@end
