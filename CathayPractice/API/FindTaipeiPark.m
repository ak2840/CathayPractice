//
//  FindTaipeiPark.m
//  CathayPractice
//
//  Created by 梁政倫 on 2017/7/8.
//  Copyright © 2017年 梁政倫. All rights reserved.
//

#import "FindTaipeiPark.h"

#define ParkDataAPI @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812&limit=%@&offset=%@"

@interface FindTaipeiPark ()

@property (nonatomic, assign) NSUInteger startIndex;

@property (nonatomic, assign) NSUInteger count;

@end

@implementation FindTaipeiPark

- (instancetype)initWithStartIndex:(NSUInteger)startIndex withCount:(NSUInteger)count;
{
    self = [super init];
    if (self)
    {
        _startIndex = startIndex;
        _count = count;
    }
    return self;
}

- (void)startGetData
{
    NSString *urlString = [NSString stringWithFormat:ParkDataAPI, @(_count), @(_startIndex)];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self parsingWithData:data];
        
    }];
    [dataTask resume];
  
}

- (void)parsingWithData:(NSData *)data
{
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSLog(@"%@", json);
    
    NSDictionary *result = [json objectForKey:@"result"];

    if ([result isKindOfClass:[NSDictionary class]])
    {
        //總數
        _totalCount = [[result objectForKey:@"count"] unsignedIntegerValue];
        
        //park data
        NSMutableArray *parkDatas = [NSMutableArray array];
        NSArray *results = [result objectForKey:@"results"];
        for (NSDictionary *result in results)
        {
            ParkData *parkData = [[ParkData alloc] initWithData:result];
            if (parkData)
            {
                [parkDatas addObject:parkData];
            }
        }
        _parkDatas = [parkDatas copy];
        
        //有資料則為成功
        _isSucess = _parkDatas.count > 0;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{

        if ([_delegate respondsToSelector:@selector(findTaipeiParkDone:)])
        {
            [_delegate findTaipeiParkDone:self];
        }
    });
 
}

@end
