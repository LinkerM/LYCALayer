//
//  LYBasicViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/13.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYBasicViewController.h"

@interface LYBasicViewController ()

@property (strong, nonatomic) UIView *pinkView;

@property (strong, nonatomic) UIView *yellowView;

@property (strong, nonatomic) UIImageView *dogimageView;

@property (strong, nonatomic) UIView *cusView;

@property (weak, nonatomic) CALayer *layer;
@end

@implementation LYBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     是因为iOS7 viewController背景颜色的问题，其实不是卡顿，是由于透明色颜色重叠后视觉上的问题，只要在新push里设置下背景颜色就好了
     */
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}

- (void)setUI
{
//    UIView *pinkView = [UIView new];
//    pinkView.frame = CGRectMake(200, kNaviHeight + 30, 100, 100);
//    pinkView.backgroundColor = [UIColor systemPinkColor];
//    [self.view addSubview:pinkView];
//    self.pinkView = pinkView;
    
    UIView *yellowView = [UIView new];
    yellowView.frame = CGRectMake(200, kNaviHeight + 30, 100, 100);
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    self.yellowView = yellowView;
    
    UIImageView *dogimageView = [UIImageView new];
    dogimageView.frame = CGRectMake(200, CGRectGetMaxY(yellowView.frame) + 20, 100, 100);
    dogimageView.image = [UIImage imageNamed:@"dog.jpeg"];
    [self.view addSubview:dogimageView];
    self.dogimageView = dogimageView;
    
    UIView *cusView = [UIView new];
    cusView.frame = CGRectMake(200, CGRectGetMaxY(dogimageView.frame) + 20, 100, 100);
    cusView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cusView];
    self.cusView = cusView;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(10, kScreen_height - kNaviHeight, (kScreen_width - 60) / 3  , 30);
    btn1.backgroundColor = krandomColor;
    [btn1 setTitle:@"CALayer" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self
             action:@selector(CALayer)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 10, kScreen_height - kNaviHeight, (kScreen_width - 60) / 3  , 30);
    btn2.backgroundColor = krandomColor;
    [btn2 setTitle:@"隐式动画" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self
             action:@selector(implicitAnimationBtn)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(10, CGRectGetMaxY(btn1.frame) + 10, (kScreen_width - 60) / 3  , 30);
    btn3.backgroundColor = krandomColor;
    btn3.tag = 1003;
    [btn3 setTitle:@"UIViewLayer" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 addTarget:self
             action:@selector(UIViewLayer)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn4.frame = CGRectMake(CGRectGetMaxX(btn3.frame) + 10, CGRectGetMaxY(btn1.frame) + 10, (kScreen_width - 60) / 3  , 30);
    btn4.backgroundColor = krandomColor;
    btn4.tag = 1004;
    [btn4 setTitle:@"UIImageLayer" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 addTarget:self
             action:@selector(UIImageLayer)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn5.frame = CGRectMake(CGRectGetMaxX(btn4.frame) + 10, CGRectGetMaxY(btn1.frame) + 10, (kScreen_width - 60) / 3  , 30);
    btn5.backgroundColor = krandomColor;
    btn5.tag = 1005;
    [btn5 setTitle:@"UIViewAni" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn5 addTarget:self
             action:@selector(UIViewAni)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(50, kNaviHeight + 70, 100, 100);
    layer.position = CGPointMake(100, 200);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    self.layer = layer;
    [self.view.layer addSublayer:layer];
}

#pragma mark - 自定义layer
- (void)CALayer
{
    CALayer *layer = [CALayer layer];
    layer.frame = self.cusView.bounds;
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.cusView.layer addSublayer:layer];
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"dog.jpeg"].CGImage);
}
#pragma mark - 隐式动画
- (void)implicitAnimationBtn
{
    // 动画底层都是包装成多个事务,有很多操作绑定在一起，当这些操作全部执行完毕时，它才进行下一步操作
    [CATransaction begin];
    // 设置变化动画过程是否显示，默认为YES不显示
    [CATransaction setDisableActions:NO];
    // 设计事务动画的执行时长
    [CATransaction setAnimationDuration:1.0f];
    
    self.layer.bounds = CGRectMake(100, 100, arc4random_uniform(200), arc4random_uniform(200));
    self.layer.position = CGPointMake(arc4random_uniform(300) + 100, arc4random_uniform(400) + 100);
    self.layer.backgroundColor = krandomColor.CGColor;
    self.layer.cornerRadius = arc4random_uniform(self.layer.bounds.size.width);
    [CATransaction commit];
}
#pragma mark - UIViewLayer
- (void)UIViewLayer
{
    // UIView本身就自带阴影效果
    self.yellowView.layer.shadowOpacity = 1;
    // 阴影偏移量
    self.yellowView.layer.shadowOffset = CGSizeMake(-30, -10);
    // 设置阴影的模糊程度
    self.yellowView.layer.shadowRadius = 10;
    // 设置阴影的背景颜色
    self.yellowView.layer.shadowColor = [UIColor redColor].CGColor;
    // 设置阴影的边框颜色
    self.yellowView.layer.borderColor = [UIColor purpleColor].CGColor;
    //设置边框的宽度
    self.yellowView.layer.borderWidth = 2;
    //设置圆角半径.
    self.yellowView.layer.cornerRadius = 50;
    
}
#pragma mark - UIImageLayer
- (void)UIImageLayer
{
    // UIView本身就自带阴影效果,它是透明.
    self.dogimageView.layer.shadowOpacity = 1;
    // 设置阴影的偏移量
    self.dogimageView.layer.shadowOffset = CGSizeMake(-30, -10);
    // 设置阴影的模糊程度
    self.dogimageView.layer.shadowRadius = 10;
    // 设置阴影的颜色
    self.dogimageView.layer.shadowColor = [UIColor blueColor].CGColor;
    // 设置边框的颜色
    self.dogimageView.layer.borderColor = [UIColor greenColor].CGColor;
    // 设置边框的宽度
    self.dogimageView.layer.borderWidth = 2;
    // 设置圆角半径.
    self.dogimageView.layer.cornerRadius = 50;
    // 超过根层以外东西都会被裁剪掉.
    self.dogimageView.layer.masksToBounds = YES;
}
#pragma mark - 旋转
- (void)UIViewAni
{
    [UIView animateWithDuration:1 animations:^{
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2];
        rotationAnimation.duration = 1;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 2;
        [self.dogimageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }];
}
@end
