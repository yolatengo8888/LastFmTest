//
//  LastFmAPI.m
//  LastFmTest
//
//  Created by yolatengo8888 on 12/02/11.
//  Copyright (c) 2012年 @yolatengo8888. All rights reserved.
//

#import "LastFmAPI.h"
#import "SBJson.h"
#import "ArtistInfo.h"

@implementation LastFmAPI

static NSString *const API_KEY = @"6eed877e11ced65724a07ab6467df1f8";
static NSString *const BASE_URL = @"http://ws.audioscrobbler.com/2.0/?method=%@&api_key=%@&format=json%@";

#pragma mark - private method

+ (void)degugOut:(id)obj 
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    writer.humanReadable = YES;
    writer.sortKeys = YES;
    NSLog(@"%@", [writer stringWithObject:obj]);
}

+ (NSURL *)createURL:(NSString *)method :(NSString *)parameter 
{
    NSString *api = [NSString stringWithFormat:BASE_URL, method, API_KEY, parameter];
    return [NSURL URLWithString:api];
}

+ (NSString *)percentEscape:(NSString *)str 
{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)requestTo:(NSURL *)url 
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error != nil) {
        return nil;
    }
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *jsonData = [parser objectWithData: resultData];
  
    return jsonData;
}

#pragma mark - public method

+ (NSArray *)searchArtists:(NSString*)keyword 
{
    NSString *escapeStr = [self percentEscape:keyword];
    NSString *searchParameter = [NSString stringWithFormat:@"&artist=%@", escapeStr];
    NSURL *url = [self createURL:@"artist.search" :searchParameter];
    NSDictionary *jsonData = [self requestTo:url];
    if (!jsonData) {
        return nil;
    }
    
    NSDictionary *results = [jsonData objectForKey:@"results"];
    NSDictionary *artistMatches = [results objectForKey:@"artistmatches"];

    int hitCount = [[results objectForKey:@"opensearch:totalResults"] intValue];
    switch (hitCount) {
        case 0:
            return nil;
            break;
        case 1:
            {
                ArtistInfo* artistInfo = [[ArtistInfo alloc] initWithInfo:[artistMatches objectForKey:@"artist"]];
                return [[NSArray alloc] initWithObjects:artistInfo, nil];
            }
            break;
        default:
            break;
    }
    
    return [ArtistInfo initWithInfoArray:[artistMatches objectForKey:@"artist"]];    
}

// 実装途中
+ (NSArray *)searchEvents:(NSString*)artistName 
{
    NSString *escapeStr = [self percentEscape:artistName];
    NSString *searchParameter = [NSString stringWithFormat:@"&artist=%@", escapeStr];
    NSURL *url = [self createURL:@"artist.getevents" :searchParameter];
    NSDictionary *jsonData = [self requestTo:url];
    if (!jsonData) {
        return nil;
    }

    NSArray *events = [jsonData objectForKey:@"events"];    

    return events;
}

@end
