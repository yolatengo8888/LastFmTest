//
//  MasterViewController.h
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController  <UISearchBarDelegate> {
@private
    NSArray *artists_;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
