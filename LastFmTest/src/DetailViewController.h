//
//  DetailViewController.h
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArtistInfo;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) ArtistInfo *artistInfo;
@property (weak, nonatomic) IBOutlet UIImageView *artistImage;

@end
