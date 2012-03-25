//
//  EventInfo.h
//  LastFmTest
//
//  Created by tjfmf812 on 12/03/12.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventInfo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *startDate;
@property (strong, nonatomic) NSString *venueName;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) NSString *url;

- (id)initWithInfo:(NSDictionary *)eventInfo;
+ (NSArray *)initWithInfoArray:(NSArray *)eventInfoes;

@end
