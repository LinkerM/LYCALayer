//
//  LYReflectionView.m
//  LYCALayer
//
//  Created by Joint on 2019/12/17.
//  Copyright © 2019 Joint. All rights reserved.
//

#import "LYReflectionView.h"

@implementation LYReflectionView

// return当前layer的类型
+ (Class)layerClass {
    return [CAReplicatorLayer class];
}


@end
