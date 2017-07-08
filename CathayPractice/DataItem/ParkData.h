//
//  ParkData.h
//  CathayPractice
//
//  Created by 梁政倫 on 2017/7/8.
//  Copyright © 2017年 梁政倫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParkData : NSObject

@property (nonatomic, strong) NSString *parkID;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *parkName;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *openTime;

@property (nonatomic, strong) NSString *introduction;

@property (nonatomic, strong) NSString *yearBuilt;


- (instancetype)initWithData:(NSDictionary *)dataDic;

@end
