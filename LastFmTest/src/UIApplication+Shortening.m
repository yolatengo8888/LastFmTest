//
//  UIApplication+Shortening.m
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "UIApplication+Shortening.h"

@implementation UIApplication(Shortening)

+ (void)showIndicator:(BOOL)isShow 
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = isShow;
}

@end
