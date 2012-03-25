//
//  InfoHelper.m
//  LastFmTest
//
//  Created by tjfmf812 on 12/03/12.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "InfoHelper.h"

@implementation InfoHelper

+ (NSArray *)initWithInfoArray:(NSArray *)eventInfoes :(InitBlock) initBlock
{
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    NSEnumerator* enumLink = [eventInfoes objectEnumerator];
    NSDictionary* item;
    while (item = (NSDictionary*)[enumLink nextObject]) {
        id obj = initBlock(item);
        [retArray addObject:obj];
    }
    
    return retArray;
}

@end
