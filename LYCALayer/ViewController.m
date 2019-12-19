//
//  ViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/13.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "ViewController.h"
#import "LYBasicViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) NSArray *classNames;

@property (strong, nonatomic) UITableView *tableView;
@end


@implementation ViewController

#pragma mark setter & getter
- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[
            @"01 - CALayer的基本操作",
            @"02 - 时钟效果",
            @"03 - 心跳效果/转场动画",
            @"04 - 图片折叠",
            @"05 - 震动条/波纹",
            @"06 - 倒影",
            @"07 - 粒子效果",
            @"08 - QQ粘性布局",
            @"09 - 马赛克"
        ];
    }
    return _dataArray;
}
- (NSArray *)classNames
{
    if (!_classNames) {
        _classNames = @[
            @"LYBasicViewController",
            @"LYClockViewController",
            @"LYHeartbeatViewController",
            @"LYImageFoldFoldViewController",
            @"LYMusicBeatViewController",
            @"LYInvertedViewController",
            @"LYParticleViewController",
            @"LYViscousLayoutViewController",
            @"LYMosaicViewController",
        ];
    }
    return _classNames;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, 64, kScreen_width, kScreen_height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationItem.title = @"CALayer";
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"titleCell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * className = self.classNames[indexPath.row];
    UIViewController *vc = [self stringChangeToClass:className];
    vc = [self stringChangeToClass:className];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/**
 * @brief 将字符串转化为控制器.
 *
 * @param str 需要转化的字符串.
 *
 * @return 控制器(需判断是否为空).
 */
- (UIViewController *)stringChangeToClass:(NSString *)str {
    id vc = [[NSClassFromString(str) alloc ] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}
@end
