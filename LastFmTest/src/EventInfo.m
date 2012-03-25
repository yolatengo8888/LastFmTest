//
//  EventInfo.m
//  LastFmTest
//
//  Created by tjfmf812 on 12/03/12.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "EventInfo.h"
#import "InfoHelper.h"
#import "LastFmAPI.h"

@implementation EventInfo

@synthesize title, startDate, venueName, city, street, url;

+ (NSArray *)initWithInfoArray:(NSArray *)eventInfoes 
{
    return [InfoHelper initWithInfoArray:eventInfoes
                                        :^(NSDictionary *item) {
                                            return [[EventInfo alloc] initWithInfo:item];
                                        }];
}

- (id)initWithInfo:(NSDictionary *)eventInfo 
{    
    self = [[EventInfo alloc] init];
    if (self) {
        self.title = [eventInfo objectForKey:@"title"];
        self.startDate = [eventInfo objectForKey:@"startDate"];
        self.url = [eventInfo objectForKey:@"url"];
        
        NSDictionary* venue = [eventInfo objectForKey:@"venue"];
        self.venueName = [venue objectForKey:@"name"];
        
        NSDictionary* location = [venue objectForKey:@"location"];
        self.city = [location objectForKey:@"city"];
        self.street = [location objectForKey:@"street"];
    }
    return self;    
}

@end
