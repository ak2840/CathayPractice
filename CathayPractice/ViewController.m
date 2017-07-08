//
//  ViewController.m
//  CathayPractice
//
//  Created by 梁政倫 on 2017/7/8.
//  Copyright © 2017年 梁政倫. All rights reserved.
//

#import "ViewController.h"
#import "FindTaipeiPark.h"
#import "ParkInfoGroup.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, FindTaipeiParkDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray <ParkData *> *parkDatas;

@property (nonatomic, strong) NSMutableDictionary <NSString *,ParkInfoGroup *> *parkInfoGroups;

@end


@implementation ViewController {
    NSUInteger startIndex;
    NSUInteger count;
    NSUInteger totalCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView.allowsSelection = NO;
    
    _parkInfoGroups = [NSMutableDictionary dictionary];
    
    count = 30;
    startIndex = 0;
    [self callFindTaipeiPark];
}

- (void)callFindTaipeiPark
{
    FindTaipeiPark *findTaipeiPark = [[FindTaipeiPark alloc] initWithStartIndex:startIndex withCount:count];
    findTaipeiPark.delegate = self;
    [findTaipeiPark startGetData];
}

- (void)createParkInfoGroups
{
    for (ParkData *parkData in _parkDatas)
    {
        ParkInfoGroup *parkInfoGroup = [[ParkInfoGroup alloc] initWithData:parkData];
        [_parkInfoGroups setObject:parkInfoGroup forKey:parkData.parkID];
    }
}

#pragma -mark ** API Delegate **
- (void)findTaipeiParkDone:(FindTaipeiPark *)sender
{
    if (sender.isSucess)
    {
        totalCount = sender.totalCount;
        _parkDatas = sender.parkDatas;
        
        [self createParkInfoGroups];
        
        [_tableView reloadData];
    }
}

#pragma -mark ** Tableview Delegate **
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _parkInfoGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParkInfoGroup *parkInfoGroup = [_parkInfoGroups objectForKey:[@(indexPath.section + 1) stringValue]];
    return CGRectGetHeight(parkInfoGroup.view.frame);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParkInfoGroup *parkInfoGroup = [_parkInfoGroups objectForKey:[@(indexPath.section + 1) stringValue]];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.frame = parkInfoGroup.view.bounds;
    [cell addSubview:parkInfoGroup.view];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (startIndex >= totalCount)
    {
        return;
    }
    //判斷是否快到底 -100
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height + 100;
    if (bottomEdge >= scrollView.contentSize.height)
    {
        startIndex += count;
        if (startIndex < totalCount)
        {
            [self callFindTaipeiPark];
        }
    }
}

@end
