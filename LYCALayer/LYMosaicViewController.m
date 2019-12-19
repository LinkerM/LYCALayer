//
//  LYMosaicViewController.m
//  LYCALayer
//
//  Created by Joint on 2019/12/18.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYMosaicViewController.h"
#import "LYScratchView.h"
#import "LYRGBTool.h"
@interface LYMosaicViewController ()

@property (nonatomic, strong) LYScratchView *scratchView;

@property (nonatomic, strong) UIImageView *dogImageView;
@end

@implementation LYMosaicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LYScratchView *scratchView = [[LYScratchView alloc] initWithFrame:CGRectMake(20, kNaviHeight + 30, kScreen_width - 40, 260)];
    scratchView.surfaceImage = [UIImage imageNamed:@"dog"];
    scratchView.mosaicImage = [LYRGBTool getMosaicImageWith:[UIImage imageNamed:@"dog"] level:0];
    [self.view addSubview:scratchView];
    _scratchView = scratchView;
    
    UIImageView *dogImageView = [UIImageView new];
    dogImageView.frame = CGRectMake(20, CGRectGetMaxY(scratchView.frame) + 50, kScreen_width - 40, 260);
    [self.view addSubview:dogImageView];
    self.dogImageView = dogImageView;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(10, kScreen_height - kNaviHeight, (kScreen_width - 60) / 3  , 30);
    btn1.backgroundColor = krandomColor;
    [btn1 setTitle:@"保存" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self
                 action:@selector(save)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
        
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 10, kScreen_height - kNaviHeight, (kScreen_width - 60) / 3  , 30);
    btn2.backgroundColor = krandomColor;
    [btn2 setTitle:@"还原" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self
                 action:@selector(recover)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}
- (void)save
{
    /*
    * 参数一: 指定将来创建出来的bitmap的大小
    * 参数二: 用来指定所生成图片的背景是否为不透明，指定为YES得到的图片背景将会是黑色，反之NO表示是透明的
    * 参数三: 表示位图的缩放比例,如果设置为 0，表示让图片的缩放因子根据屏幕的分辨率而变化
    */
    UIGraphicsBeginImageContextWithOptions(self.scratchView.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.scratchView.layer renderInContext:context];
    UIImage *deadledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.dogImageView.image = deadledImage;
}
- (void)recover
{
    [self.scratchView recover];
    self.dogImageView.image = nil;
}

@end
