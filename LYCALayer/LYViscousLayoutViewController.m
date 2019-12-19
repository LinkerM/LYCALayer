//
//  LYViscousLayoutViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/18.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYViscousLayoutViewController.h"

//设置最大偏移距离为当前空间的倍数
#define MAXDistance 4

@interface LYViscousLayoutViewController ()

@property (nonatomic, strong) UIView *circle;

@property (nonatomic, strong) UIView *circle1;

@property (nonatomic, assign) CGPoint remindPoint;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation LYViscousLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}

- (void)setUI
{
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 20, 20)];
    circle.backgroundColor = [UIColor redColor];
    circle.layer.cornerRadius = 10;
    [self.view addSubview:circle];
    
    self.circle1 = [[UIView alloc] init];
    self.circle1.backgroundColor = circle.backgroundColor;
    self.circle1.center = circle.center;
    self.circle1.bounds = circle.bounds;
    self.circle1.layer.cornerRadius = circle.layer.cornerRadius;
    self.circle1.layer.masksToBounds = circle.layer.masksToBounds;
    self.circle1.hidden = YES;
    [self.view insertSubview:self.circle1 belowSubview:circle];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [circle addGestureRecognizer:panGR];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [circle addGestureRecognizer:tapGR];
    
    _remindPoint = CGPointMake(0, 0);
    self.circle = circle;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    tap.view.hidden = YES;
    self.circle1.hidden = YES;
    //爆炸效果
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:tap.view.frame];
    imageView.contentMode = UIViewContentModeCenter;
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 1 ; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"unreadBomb_%d",i]];
        [imageArr addObject:image];
    }
    imageView.animationImages = imageArr;
    imageView.animationDuration = 0.5;
    imageView.animationRepeatCount = 1;
    [imageView startAnimating];
    [self.view addSubview:imageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imageView removeFromSuperview];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        tap.view.hidden = NO;
    });
}
- (void)panAction:(UIPanGestureRecognizer *)pan
{
    if (_remindPoint.x == 0 && _remindPoint.y == 0) {
        _remindPoint = pan.view.center;
    }
    self.circle1.hidden = NO;
    //拖动
    CGPoint translation = [pan translationInView:self.view];
    CGPoint newCenter = CGPointMake(pan.view.center.x+ translation.x,
                                    pan.view.center.y + translation.y);
    newCenter.y = MAX(pan.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(self.view.frame.size.height - pan.view.frame.size.height/2,  newCenter.y);
    newCenter.x = MAX(pan.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(self.view.frame.size.width - pan.view.frame.size.width/2,newCenter.x);
    pan.view.center = newCenter;
    [pan setTranslation:CGPointZero inView:self.view];
    
    /*
     //拖动和上面的代码一样
    CGPoint newCenter = [pan locationInView:self.view];
    newCenter = [pan.view convertPoint:p toView:self.view];
    pan.view.center= newCenter;
    */
    
    //  设置circle1变化的值
    CGFloat cirDistance = [self distanceWithPointA:self.circle1.center andPointB:self.circle.center];
    CGFloat scale = 1- cirDistance / (MAXDistance * self.circle.bounds.size.height);
    if (scale < 0.2) {
        scale = 0.2;
    }
    self.circle1.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat  fx = fabs(_remindPoint.x- newCenter.x);
    CGFloat  fy = fabs(_remindPoint.y- newCenter.y);
    if (fx > MAXDistance * self.circle.bounds.size.height || fy > MAXDistance * self.circle.bounds.size.height) {
        self.shapeLayer.path = nil;
        self.circle1.hidden = YES;
    }else{
        self.circle1.hidden = NO;
        [self reloadBeziePath];
    }
    
    if (pan.state == UIGestureRecognizerStateRecognized) {
        CGFloat  fx = fabs(_remindPoint.x- newCenter.x);
        CGFloat  fy = fabs(_remindPoint.y- newCenter.y);
        if (fx > MAXDistance * self.circle.bounds.size.height || fy > MAXDistance * self.circle.bounds.size.height) {
            [self boomCells:pan.view.center];
        }else{
            [self.shapeLayer removeFromSuperlayer];
            self.shapeLayer = nil;
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.circle.center = self.circle1.center;
            } completion:^(BOOL finished) {
                self.circle1.hidden = NO;
            }];
        }
    }
}

#pragma mark - 获取圆心距离
- (CGFloat)distanceWithPointA:(CGPoint)pointA  andPointB:(CGPoint)pointB{
    CGFloat offSetX = pointA.x - pointB.x;
    CGFloat offSetY = pointA.y - pointB.y;
    return sqrt(offSetX * offSetX + offSetY * offSetY);
}

#pragma mark - 绘制贝塞尔图形
- (void) reloadBeziePath {
    CGFloat r1 = self.circle1.frame.size.width / 2.0f;
    CGFloat r2 = self.circle.frame.size.width / 2.0f;
    
    CGFloat x1 = self.circle1.center.x;
    CGFloat y1 = self.circle1.center.y;
    CGFloat x2 = self.circle.center.x;
    CGFloat y2 = self.circle.center.y;
    
    CGFloat distance = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    
    CGFloat sinDegree = (x2 - x1) / distance;
    CGFloat cosDegree = (y2 - y1) / distance;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosDegree, y1 + r1 * sinDegree);
    CGPoint pointB = CGPointMake(x1 + r1 * cosDegree, y1 - r1 * sinDegree);
    CGPoint pointC = CGPointMake(x2 + r2 * cosDegree, y2 - r2 * sinDegree);
    CGPoint pointD = CGPointMake(x2 - r2 * cosDegree, y2 + r2 * sinDegree);
    CGPoint pointP = CGPointMake(pointB.x + (distance / 2) * sinDegree, pointB.y + (distance / 2) * cosDegree);
    CGPoint pointO = CGPointMake(pointA.x + (distance / 2) * sinDegree, pointA.y + (distance / 2) * cosDegree);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: pointA];
    [path addLineToPoint: pointB];
    [path addQuadCurveToPoint: pointC controlPoint: pointP];
    [path addLineToPoint: pointD];
    [path addQuadCurveToPoint: pointA controlPoint: pointO];
    
    self.shapeLayer.path = path.CGPath;
}
#pragma mark - 粒子添加及动画
-(void)boomCells:(CGPoint)point{
    NSInteger rowClocn = 3;
    NSMutableArray *boomCells = [NSMutableArray array];
    for (int i = 0; i < rowClocn*rowClocn; ++ i) {
        CGFloat pw = MIN(self.circle.frame.size.width, self.circle.frame.size.height);
        CALayer *shape = [CALayer layer];
        shape.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0].CGColor;
        shape.cornerRadius = pw / 2;
        //shape.frame = CGRectMake((i/rowClocn) * pw, (i%rowClocn) * pw, pw, pw);
        shape.frame = CGRectMake(0, 0, pw, pw);
        [self.circle.layer.superlayer addSublayer: shape];
        [boomCells addObject: shape];
    }
    self.circle.hidden = YES;
    [self cellAnimation:boomCells];
}
- (void)cellAnimation:(NSArray*)cells {
    for (NSInteger j=0; j<cells.count;j++) {
        CALayer *shape = cells[j];
        shape.position = self.circle.center;
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.toValue = @0.5;
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
        pathAnimation.path = [self makeRandomPath: shape AngleTransformation:j].CGPath;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
        
        animationGroup.animations = @[scaleAnimation,pathAnimation,];
        animationGroup.fillMode = kCAFillModeForwards;
        animationGroup.duration = 0.5;
        animationGroup.removedOnCompletion = NO;
        animationGroup.repeatCount = 1;

        [shape addAnimation: animationGroup forKey: @"animationGroup"];
        [self performSelector:@selector(removeLayer:) withObject:shape afterDelay:animationGroup.duration];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.circle.hidden = NO;
    });
    
}
#pragma mark - 设置碎片路径
- (UIBezierPath *) makeRandomPath: (CALayer *) alayer AngleTransformation:(CGFloat)index{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.circle.center];
    CGFloat dia = self.circle.frame.size.width;
    if (index>0) {
        CGFloat angle = index*45*M_PI*2/360;
        CGFloat x = dia*cosf(angle);
        CGFloat y = dia*sinf(angle);
        [path addLineToPoint:CGPointMake(self.circle.center.x + x, self.circle.center.y+y)];
    }else{
        [path addLineToPoint:CGPointMake(self.circle.center.x, self.circle.center.y)];
    }
    return path;
}
-(void)removeLayer:(CALayer *)layer{
    [layer removeFromSuperlayer];
}
#pragma mark - setter && getter
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = self.circle.backgroundColor.CGColor;
        [self.view.layer insertSublayer:shapeLayer below:self.circle1.layer];
        _shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}
@end
