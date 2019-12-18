//
//  LYMusicBeatViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/17.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYMusicBeatViewController.h"
#import "XLKWavePulsLayer.h"

@interface LYMusicBeatViewController ()

@property (nonatomic, strong) XLKWavePulsLayer *waveLayer;

@end

@implementation LYMusicBeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 震动条
    [self musicBeat];
    // 波纹
    [self ripple];
}
#pragma mark - 震动条
- (void)musicBeat
{
    // 复制图层
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    // 设置复制图层中字层的总数：这里包含原始层
    replicatorLayer.instanceCount = 8;
    // 设置复制子层偏移量，不包含原始层，这里是相对于原始层的x轴的偏移量
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    // 设置复制层的动画延迟事件
    replicatorLayer.instanceDelay = 0.1;
    // 设置复制层的背景色，如果原始层设置了背景色，这里设置就失去效果
    replicatorLayer.instanceColor = [UIColor yellowColor].CGColor;
    // 设置复制层颜色的偏移量
    replicatorLayer.instanceGreenOffset = -0.1;
    
    // 创建图层原式层
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(30, kNaviHeight + 200);
    // 设置layer的锚点
    layer.anchorPoint = CGPointMake(0, 1);
    // 设置layer对象的位置大小
    layer.bounds = CGRectMake(0, 0, 30, 150);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    // 创建动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    // 设置动画属性
    basicAnimation.keyPath = @"transform.scale.y";
    // 设置动画的属性值
    basicAnimation.toValue = @0.1;
    // 设置次数
    basicAnimation.repeatCount = MAXFLOAT;
    // 设置动画执行时间
    basicAnimation.duration = 0.6;
    // 设置动画反转
    basicAnimation.autoreverses = YES;
    
    [layer addAnimation:basicAnimation forKey:nil];
    
    [replicatorLayer addSublayer:layer];
    
    [self.view.layer addSublayer:replicatorLayer];
}
#pragma mark - 波纹
- (void)ripple
{
    [self.view.layer addSublayer:self.waveLayer];
    self.waveLayer.position = self.view.center;
    [self.waveLayer start];
}
- (XLKWavePulsLayer *)waveLayer
{
    if (_waveLayer == nil) {
        _waveLayer = [XLKWavePulsLayer layer];
        _waveLayer.animationDuration = 6;
        _waveLayer.haloLayerNumber = 5;
        _waveLayer.fromValueForRadius = 0.0;
        _waveLayer.backgroundColor = [UIColor redColor].CGColor;
        _waveLayer.radius = 90;
    }
    return _waveLayer;
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
