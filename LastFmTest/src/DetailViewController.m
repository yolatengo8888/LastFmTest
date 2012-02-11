//
//  DetailViewController.m
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "UIApplication+Shortening.h"
#import "DetailViewController.h"
#import "LastFmAPI.h"
#import "ArtistInfo.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize artistInfo = _artistInfo;
@synthesize artistImage = _artistImage;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newArtistInfo
{
    if (_artistInfo != newArtistInfo) {
        _artistInfo = newArtistInfo;
        
        // Update the view.
        [self configureView];
    }
}

- (void)cofigureViewMain 
{
    self.title = _artistInfo.name;
    
    NSURL *url = [NSURL URLWithString:_artistInfo.imageURL];
    NSData* data = [NSData dataWithContentsOfURL:url];

    UIImage *image = nil;
    if (data) {
        image = [UIImage imageWithData:data];
    } else {
        image = [UIImage imageNamed:@"noimage.gif"];
    }
    CGRect rect = CGRectMake(10, 10, image.size.width, image.size.height);
    [_artistImage setFrame:rect];
    _artistImage.image = image;
    
    [UIApplication showIndicator:NO];        
}

- (void)configureView
{
    if (self.artistInfo) {
        // インジケータを即表示させるため、別スレッドで処理
        [UIApplication showIndicator:YES];        
        [self performSelectorInBackground:@selector(cofigureViewMain) withObject:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setArtistImage:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configureView];
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
    _artistImage.image = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}
							
@end
