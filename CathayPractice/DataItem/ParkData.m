//
//  ParkData.m
//  CathayPractice
//
//  Created by 梁政倫 on 2017/7/8.
//  Copyright © 2017年 梁政倫. All rights reserved.
//

#import "ParkData.h"

@implementation ParkData

- (instancetype)initWithData:(NSDictionary *)dataDic;
{
    self = [super init];
    if (self)
    {
        if (![dataDic isKindOfClass:[NSDictionary class]])
        {
            return nil;
        }
        
        _parkID = [dataDic objectForKey:@"_id"];
        
        _name = [dataDic objectForKey:@"Name"];
        
        _parkName = [dataDic objectForKey:@"ParkName"];
        
        _image = [dataDic objectForKey:@"Image"];
        
        _openTime = [dataDic objectForKey:@"OpenTime"];
        
        _introduction = [dataDic objectForKey:@"Introduction"];
        
        _yearBuilt = [dataDic objectForKey:@"YearBuilt"];
    }
    return self;
}

@end
