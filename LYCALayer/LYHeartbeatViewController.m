//
//  LYHeartbeatViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/16.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYHeartbeatViewController.h"

@interface LYHeartbeatViewController ()

@property (nonatomic, strong) UIImageView *qImage;

@property (nonatomic, strong) UIImageView *heartImage;
@end

static int _i = 1;

@implementation LYHeartbeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
    [self transition];
}
- (void)setUI
{
    UIImageView *qImage = [UIImageView new];
    qImage.frame = CGRectMake(kScreen_width / 2 - 100, kNaviHeight + 30, 200, 300);
    qImage.backgroundColor = [UIColor redColor];
    qImage.image = [UIImage imageNamed:@"timg.jpeg"];
    [self.view addSubview:qImage];
    self.qImage = qImage;
    
    UIImageView *heartImage = [UIImageView new];
    heartImage.frame = CGRectMake(kScreen_width / 2 - 40, CGRectGetMaxY(qImage.frame) + 80, 80, 80);
    heartImage.backgroundColor = [UIColor redColor];
    heartImage.image = [UIImage imageNamed:@"heartImageV.png"];
    [self.view addSubview:heartImage];
    self.heartImage = heartImage;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(10, kScreen_height - kNaviHeight, (kScreen_width - 60) / 3  , 30);
    btn1.backgroundColor = krandomColor;
    [btn1 setTitle:@"转场" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self
              action:@selector(transitionBtn)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
     
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 10, kScreen_height - kNaviHeight, (kScreen_width - 60) / 3  , 30);
    btn2.backgroundColor = krandomColor;
    [btn2 setTitle:@"心跳" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self
              action:@selector(heartbeatBtn)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

-(void)transition
{
    // 转场代码必须和转场动画在一个方法中
    // 创建
    CATransition *transtion = [CATransition animation];
    // 类型
    transtion.type = @"pageCurl";
    // 方向
    transtion.subtype = kCATransitionFromTop;
    // 开始的点
    transtion.startProgress = 0.2;
    // 结束的点
    transtion.endProgress = 0.8;
    transtion.duration = 1;
    [self.qImage.layer addAnimation:transtion forKey:nil];
    // 转场
    _i ++;
    if (_i > 3) {
        _i = 1;
    }
    self.qImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"liqin%d",_i]];
}

#pragma mark - 转场
- (void)transitionBtn
{
    [UIView transitionWithView:self.qImage duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        _i ++;
        if (_i > 3) {
            _i = 1;
        }
        self.qImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"liqin%d",_i]];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 心跳
- (void)heartbeatBtn
{
    // 创建
    CABasicAnimation *animation = [CABasicAnimation animation];
    //设置属性
    animation.keyPath = @"transform.scale";
    //设置属性值
    animation.toValue = @0.2;
    //设置动画的执行次数
    animation.repeatCount = MAXFLOAT;
    //设置动画的执行时长
    animation.duration = 1.0;
    // 自动反转
    animation.autoreverses = YES;
    // 添加动画
    [self.heartImage.layer addAnimation:animation forKey:nil];
}
@end
