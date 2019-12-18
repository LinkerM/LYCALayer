//
//  LYParticleViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/17.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYParticleViewController.h"

@interface LYParticleViewController ()

@end

@implementation LYParticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *particleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [particleBtn setTitle:@"粒子" forState:UIControlStateNormal];
    [particleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [particleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    particleBtn.frame = CGRectMake(0, 0, 100, 40);
    particleBtn.center = CGPointMake(self.view.center.x, kScreen_height - 80);
    [particleBtn addTarget:self action:@selector(particleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    particleBtn.selected = NO;
    [self.view addSubview:particleBtn];
}
- (void)particleBtnClick:(UIButton *)btn
{
    if (btn.selected == NO)
    {
        [self setupPartic];
        btn.selected = YES;
    }else
    {
        [self stopPartic];
        btn.selected = NO;
        
    }
}

// 粒子效果
- (void)setupPartic
{
    // 创建发射器
    CAEmitterLayer *emitter = [[CAEmitterLayer alloc] init];
    // 发射器位置
    emitter.emitterPosition = CGPointMake(self.view.center.x, kScreen_height - 80);
    //
    emitter.preservesDepth = YES;
    // 创建粒子
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    // 设置粒子速度
    cell.velocity = 150;
    //速度范围波动
    cell.velocityRange = 100;
    // 设置粒子的大小 一般我们的粒子大小就是图片大小， 我们一般做个缩放
    cell.scale = 0.7;
    // 粒子大小范围: 0.4 - 1 倍大
    cell.scaleRange = 0.3;
    // 设置粒子方向
    //这个是设置经度，就是竖直方向 --具体看我们下面图片讲解
    //这个角度是逆时针的，所以我们的方向要么是 (2/3 π)， 要么是 (-π)
    cell.emissionLongitude = -M_PI_2;
    cell.emissionRange = M_PI_2 / 4;
    
    // 设置粒子的存活时间
    cell.lifetime = 6;
    cell.lifetimeRange = 1.5;
    // 设置粒子旋转
    cell.spin = M_PI_2;
    cell.spinRange = M_PI_2 / 2;
    // 设置粒子每秒弹出的个数
    cell.birthRate = 20;
    // 获取0-9随机数
    int x = arc4random() % 10;
    // 设置粒子展示的图片 --这个必须要设置为CGImage
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30",x]].CGImage);
    // 将粒子设置到发射器中--这个是要放个数组进去
    emitter.emitterCells = @[cell];
    [self.view.layer addSublayer:emitter];
}

// 移除粒子
- (void)stopPartic
{
    for(CALayer *emitter in self.view.layer.sublayers){
        if ([emitter isKindOfClass:[CAEmitterLayer class]]) {
            [emitter removeFromSuperlayer];
        }
    }
}
@end
