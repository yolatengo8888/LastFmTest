//
//  MasterViewController.m
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "UIApplication+Shortening.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "LastFmAPI.h"
#import "ArtistInfo.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Search Artist";
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    artists_ = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!artists_) {
        return 0;
    }

    return [artists_ count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
    ArtistInfo* artistInfo = [artists_ objectAtIndex:indexPath.row];
    cell.textLabel.text = artistInfo.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArtistInfo* artistInfo = [artists_ objectAtIndex:indexPath.row];

    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    self.detailViewController.artistInfo = artistInfo;

    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (void)searchArtists:(NSString *)keyword 
{
    artists_ = [LastFmAPI searchArtists:keyword];
    UITableView *tableView = (UITableView *)self.view;
    [tableView reloadData];
    
    [UIApplication showIndicator:NO];
}

#pragma mark - Search Bar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
    // インジケータを即表示させるため、別スレッドで処理
    [UIApplication showIndicator:YES];
    [self performSelectorInBackground:@selector(searchArtists:) withObject:[searchBar text]];
    [searchBar resignFirstResponder];    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar 
{
    [searchBar resignFirstResponder]; 
}

@end
