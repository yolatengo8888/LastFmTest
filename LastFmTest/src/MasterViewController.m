//
//  MasterViewController.m
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "UIApplication+Shortening.h"
#import "MasterViewController.h"
#import "EventViewController.h"
#import "LastFmAPI.h"
#import "ArtistInfo.h"

@implementation MasterViewController

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
    _artists = nil;
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_artists) {
        return 0;
    }

    return [_artists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    ArtistInfo* artistInfo = [_artists objectAtIndex:indexPath.row];
    cell.textLabel.text = artistInfo.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArtistInfo* artistInfo = [_artists objectAtIndex:indexPath.row];

    EventViewController *eventViewController = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
    eventViewController.artistInfo = artistInfo;

    [self.navigationController pushViewController:eventViewController animated:YES];
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

- (void)searchArtists:(NSString *)keyword 
{
    _artists = [LastFmAPI searchArtists:keyword];

    UITableView *tableView = (UITableView *)self.view;
    [tableView reloadData];
    
    [UIApplication showIndicator:NO];
}

@end
