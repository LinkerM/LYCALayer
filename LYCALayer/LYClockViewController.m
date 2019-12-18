//
//  LYClockViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/13.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYClockViewController.h"

// 每一秒旋转
#define rotateSecond 6
// 每一分旋转
#define rotateMinute 6
// 每一小时旋转30
#define rotateHour 30
// 第一分时针旋转的度数
#define rotateMinHour 0.5

#define angleRad(angle) ((angle) / 180.0 * M_PI)

@interface LYClockViewController ()

@property (strong, nonatomic) UIImageView *clockImageView;

@property(weak, nonatomic) CALayer *secondLayer;

@property(weak, nonatomic) CALayer *minuteLayer;

@property(weak, nonatomic) CALayer *hourLayer;

@end

@implementation LYClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加表盘
    [self addClock];
    
    // 添加时针
    [self addHour];
    
    // 添加分针
    [self addMinue];
    
    // 添加秒针
    [self addSecond];

    // 添加定时器
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    [self timeChange];
    
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectMake(0, 0, 6, 6);
//    layer.backgroundColor = [UIColor blackColor].CGColor;
//    layer.cornerRadius = layer.bounds.size.width * 0.5;
//    layer.position = CGPointMake(self.clockImageView.bounds.size.width * 0.5, self.clockImageView.bounds.size.height * 0.5);
//    [self.clockImageView.layer addSublayer:layer];
}

- (void)timeChange
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //components日历单元:年,月,日,时,分,秒
    //fromDate:从哪个时间开始取
    NSDateComponents *cmp = [calendar components:NSCalendarUnitSecond |
                                                 NSCalendarUnitHour |
                                                 NSCalendarUnitMinute
                                        fromDate:[NSDate date]];
    //获取秒
    NSInteger curSecond = cmp.second;
    //获取分
    NSInteger curMinute = cmp.minute;
    //获取时
    NSInteger curHour = cmp.hour;
    
    // 秒针转动度数
    CGFloat second = curSecond * rotateSecond;
    self.secondLayer.transform = CATransform3DMakeRotation(angleRad(second), 0, 0, 1);
    
    // 分针转动度数
    CGFloat minute = curMinute * rotateMinute;
    self.minuteLayer.transform = CATransform3DMakeRotation(angleRad(minute), 0, 0, 1);
    
    // 时针转动度数
    CGFloat hour = curHour * rotateHour + curMinute * rotateMinHour;
    self.hourLayer.transform = CATransform3DMakeRotation(angleRad(hour), 0, 0, 1);
}

- (void)addClock
{
    UIImageView *clockImage = [UIImageView new];
    clockImage.frame = CGRectMake(kScreen_width / 2 - 100, 200, 200, 200);
    clockImage.backgroundColor = [UIColor redColor];
    clockImage.image = [UIImage imageNamed:@"timg.jpeg"];
    [self.view addSubview:clockImage];
    self.clockImageView = clockImage;
}

- (void)addHour
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 2.5, 50);
    layer.position = CGPointMake(self.clockImageView.bounds.size.width * 0.5, self.clockImageView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 0.95);
    self.hourLayer = layer;
    [self.clockImageView.layer addSublayer:layer];
}

- (void)addMinue
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 2, 70);
    layer.position = CGPointMake(self.clockImageView.bounds.size.width * 0.5, self.clockImageView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.minuteLayer = layer;
    [self.clockImageView.layer addSublayer:layer];
}

- (void)addSecond
{
    //根据锚点进旋转,缩放
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 1, 82);
    layer.position = CGPointMake(self.clockImageView.bounds.size.width * 0.5, self.clockImageView.bounds.size.height * 0.5);
    layer.anchorPoint = CGPointMake(0.5, 0.85);
    self.secondLayer = layer;
    [self.clockImageView.layer addSublayer:layer];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
