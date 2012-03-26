//
//  EventViewController.m
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/25.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <Twitter/TWTweetComposeViewController.h>

#import "EventViewController.h"
#import "ArtistInfo.h"
#import "LastFmAPI.h"
#import "EventInfo.h"
#import "UIApplication+Shortening.h"

@implementation EventViewController

@synthesize artistInfo = _artistInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - call api

- (void)searchEvents:(NSString *)artistName 
{
    _events = [LastFmAPI searchEvents:artistName];
    
    UITableView *tableView = (UITableView *)self.view;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;    
    [tableView reloadData];
    
    [UIApplication showIndicator:NO];
}

#pragma mark - twitter

- (void)tweet:(NSString *)text
{
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    [twitter setInitialText:text];
    [self presentModalViewController:twitter animated:YES];
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        switch (result)
        {
            case TWTweetComposeViewControllerResultDone:
            {
                NSString *message = @"ツイートしました.";
                UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:@"ツイート完了" 
                                                                 message:message
                                                                 delegate:nil 
                                                        cancelButtonTitle:@"OK" 
                                                        otherButtonTitles:nil];
                [alert show];
                break;
            }
            default:
                break;
        }
        [self dismissModalViewControllerAnimated:YES];
    };
}

#pragma mark - View configure

- (void)cofigureViewMain 
{
    self.title = _artistInfo.name;
    [self searchEvents:_artistInfo.name];
    
    [UIApplication showIndicator:NO];        
}

- (void)configureView
{
    if (_artistInfo) {
        [UIApplication showIndicator:YES];        
        [self performSelectorInBackground:@selector(cofigureViewMain) withObject:nil];
    }
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [self configureView];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _events = nil;
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_events) {
        return 0;
    }

    return [_events count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.detailTextLabel.numberOfLines = 3; 
    }
    
    EventInfo* eventInfo = [_events objectAtIndex:indexPath.row];
    cell.textLabel.text = eventInfo.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\nat %@(%@ %@)", 
                                 eventInfo.startDate, 
                                 eventInfo.venueName,
                                 eventInfo.city,
                                 eventInfo.street];
    
    return cell;
}

const int TWEET_MAX_LENGTH = 140;
const int T_CO_URL_LENGTH = 20;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    EventInfo *eventInfo = [_events objectAtIndex:indexPath.row];
    NSString *tweetText = [NSString stringWithFormat:@"%@ / %@ at %@(%@ %@)", 
                           eventInfo.title,
                           eventInfo.startDate, 
                           eventInfo.venueName,
                           eventInfo.city,
                           eventInfo.street];
    // +1はスペース１文字
    if (tweetText.length + T_CO_URL_LENGTH + 1 > TWEET_MAX_LENGTH) {
        // 140文字を超えるときは住所を省略
        tweetText = [NSString stringWithFormat:@"%@ / %@ at %@(%@)", 
                               eventInfo.title,
                               eventInfo.startDate, 
                               eventInfo.venueName,
                               eventInfo.city];
    }
    
    [self tweet:[NSString stringWithFormat:@"%@ %@", tweetText, eventInfo.url]];
}

@end
