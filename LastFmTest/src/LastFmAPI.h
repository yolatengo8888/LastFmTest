//
//  LastFmAPI.h
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastFmAPI : NSObject
+ (void) degugOut:(id)obj;
+ (NSArray *)searchArtists:(NSString*)keyword;
+ (NSArray *)searchEvents:(NSString*)artistName;
@end
