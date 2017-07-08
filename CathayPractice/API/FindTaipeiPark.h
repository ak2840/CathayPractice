//
//  FindTaipeiPark.h
//  CathayPractice
//
//  Created by 梁政倫 on 2017/7/8.
//  Copyright © 2017年 梁政倫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParkData.h"

@class FindTaipeiPark;

@protocol FindTaipeiParkDelegate <NSObject>

@optional
- (void)findTaipeiParkDone:(FindTaipeiPark *)sender;

@end


@interface FindTaipeiPark : NSObject

@property (nonatomic, assign) BOOL isSucess;

@property (nonatomic, assign) NSUInteger totalCount;

@property (nonatomic, strong) NSArray <ParkData *> *parkDatas;


@property (nonatomic, weak) id <FindTaipeiParkDelegate> delegate;

- (instancetype)initWithStartIndex:(NSUInteger)startIndex withCount:(NSUInteger)count;

- (void)startGetData;

@end
