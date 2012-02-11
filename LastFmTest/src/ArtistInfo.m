//
//  ArtistInfo.m
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "ArtistInfo.h"

@implementation ArtistInfo

@synthesize name, imageURL;

- (NSString *)getUrlString:(NSDictionary *)artistInfo size:(NSString *)size 
{
    NSArray *images = [artistInfo objectForKey:@"image"];
    for (NSDictionary *imageInfo in images) {
        NSString *imageSize = [imageInfo objectForKey:@"size"];
        if ([imageSize isEqualToString:size]) {
            return [NSString stringWithString:[imageInfo objectForKey:@"#text"]];
        }
    }
    return nil;
}

+ (NSArray *)initWithInfoArray:(NSArray *)artistInfoes 
{
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSEnumerator* enumLink = [artistInfoes objectEnumerator];
    NSDictionary* item;
    while (item = (NSDictionary*)[enumLink nextObject]) {
        [retArray addObject:[[ArtistInfo alloc] initWithInfo:item]];
    }
    
    return retArray;
}

- (id)initWithInfo:(NSDictionary *)artistInfo 
{
    self = [[ArtistInfo alloc] init];
    if (self) {
        self.name = [artistInfo objectForKey:@"name"];
        self.imageURL = [self getUrlString:artistInfo size:@"extralarge"];
    }
    return self;    
}

@end
