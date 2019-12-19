//
//  LYPixelItem.h
//  LYCALayer
//
//  Created by Joint on 2019/12/18.
//  Copyright © 2019 Joint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYPixelItem : NSObject

/** 当前像素点的RGBA */
@property (nonatomic, strong) UIColor *color;
/** 当前像素点的坐标 */
@property (nonatomic, assign) CGPoint location;

@end

NS_ASSUME_NONNULL_END
