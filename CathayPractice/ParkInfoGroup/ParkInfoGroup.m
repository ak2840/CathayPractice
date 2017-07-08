//
//  ParkInfoGroup.m
//  CathayPractice
//
//  Created by 梁政倫 on 2017/7/8.
//  Copyright © 2017年 梁政倫. All rights reserved.
//

#import "ParkInfoGroup.h"
#import "UIImageView+WebCache.h"

@interface ParkInfoGroup ()

@property (nonatomic, strong) ParkData *parkData;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *parkName;

@property (weak, nonatomic) IBOutlet UILabel *openTime;

@property (weak, nonatomic) IBOutlet UILabel *introduction;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end


@implementation ParkInfoGroup

- (instancetype)initWithData:(ParkData *)parkData;
{
    self = [super init];
    if (self) {
        _parkData = parkData;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //UI
    self.name.text = _parkData.name;
    self.parkName.text = _parkData.parkName;
    self.openTime.text = _parkData.openTime;
    self.introduction.text = _parkData.introduction;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:_parkData.image]];

    //計算introduction 需要拉長多少
    CGRect introductionFrame = self.introduction.frame;
    CGSize introductionSize = [self.introduction sizeThatFits:CGSizeMake(introductionFrame.size.width, CGFLOAT_MAX)];
    CGFloat offset = introductionSize.height - introductionFrame.size.height;
    CGRect frame = self.view.frame;
    frame.size.height += offset;
    self.view.frame = frame;
}

@end
