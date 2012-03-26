//
//  EventViewController.h
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/25.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArtistInfo;
@class TweetViewController;

@interface EventViewController : UITableViewController {
@private
    NSArray *_events;
}

@property (weak, nonatomic) ArtistInfo *artistInfo;

@end
