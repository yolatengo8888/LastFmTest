//
//  ArtistInfo.h
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistInfo : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;

- (id)initWithInfo:(NSDictionary *)artistInfo;

+ (NSArray *)initWithInfoArray:(NSArray *)artistInfoes;

@end
