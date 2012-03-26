//
//  InfoHelper.h
//  LastFmTest
//
//  Created by yolatengo8888 on 12/03/12.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^InitBlock)(NSDictionary* item);

@interface InfoHelper : NSObject
+ (NSArray *)initWithInfoArray:(NSArray *)eventInfoes :(InitBlock) initBlock;
@end
