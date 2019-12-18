//
//  LYImageFoldFoldViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/17.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYImageFoldFoldViewController.h"

@interface LYImageFoldFoldViewController ()

@property (strong, nonatomic) UIImageView *topImageView;

@property (strong, nonatomic) UIImageView *bottomImageView;

@property (strong, nonatomic) UIView      *drawView;

@property (nonatomic, weak) CAGradientLayer *gradientLayer;
@end

@implementation LYImageFoldFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}
- (void)setUI
{
    UIImageView *topImageView = [UIImageView new];
    topImageView.image = [UIImage imageNamed:@"dogFold.jpeg"];
    topImageView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    topImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    topImageView.frame = CGRectMake(kScreen_width / 2 - 100, kScreen_height / 2 - 100, 200, 100);
    [self.view addSubview:topImageView];
    self.topImageView = topImageView;
    
    UIImageView *bottomImageView = [UIImageView new];
    bottomImageView.image = [UIImage imageNamed:@"dogFold.jpeg"];
    bottomImageView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    bottomImageView.layer.anchorPoint = CGPointMake(0.5, 0.0);
    bottomImageView.frame = CGRectMake(kScreen_width / 2 - 100, CGRectGetMaxY(topImageView.frame), 200, 100);
    [self.view addSubview:bottomImageView];
    self.bottomImageView = bottomImageView;
    
    UIView *drawView = [UIView new];
    drawView.frame = CGRectMake(kScreen_width / 2 - 100, kScreen_height / 2 - 160 , 200, 320);
    drawView.userInteractionEnabled = YES;
    [self.view addSubview:drawView];
    self.drawView = drawView;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.drawView addGestureRecognizer:pan];
    
    // 底部图片渐变
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bottomImageView.bounds;
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    gradientLayer.opacity = 0;
    self.gradientLayer = gradientLayer;
    [self.bottomImageView.layer addSublayer:gradientLayer];
}

- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint transP = [pan translationInView:self.drawView];
    CATransform3D transform = CATransform3DIdentity;
    //立体的效果， 近大远小
    transform.m34 = -1 /550.0;
    //设置不透明度
    CGFloat opcity = transP.y * 1 /256.0;
    self.gradientLayer.opacity = opcity;
    CGFloat angle = transP.y * M_PI /256.0;
    //让上半部分做旋转
    self.topImageView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.gradientLayer.opacity = 0;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            //让上部图片反弹回去
            self.topImageView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}
@end
