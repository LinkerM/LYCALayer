//
//  LYInvertedViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/17.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYInvertedViewController.h"
#import "LYReflectionView.h"
@interface LYInvertedViewController ()

@property (nonatomic, strong) LYReflectionView *refView;

@property (nonatomic, strong) UIImageView *iamgeView;

@end

@implementation LYInvertedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _refView = [LYReflectionView new];
    _refView.frame = self.view.frame;
    _refView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.refView];
    [self setUI];
}

- (void)setUI
{

    UIImageView *iamgeView = [UIImageView new];
    iamgeView.frame = CGRectMake(kScreen_width / 2 - 100, kNaviHeight + 30, 200, 350);
    iamgeView.backgroundColor = [UIColor redColor];
    iamgeView.image = [UIImage imageNamed:@"inverted"];
    [self.refView addSubview:iamgeView];
    self.iamgeView = iamgeView;
    
    CAReplicatorLayer *repLayer = (CAReplicatorLayer *)self.refView.layer;
    repLayer.instanceCount = 2;
    repLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    repLayer.instanceRedOffset -= 0.1;
    repLayer.instanceGreenOffset -= 0.1;
    repLayer.instanceBlueOffset -= 0.1;
    repLayer.instanceAlphaOffset -= 0.1;
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
