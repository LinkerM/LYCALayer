//
//  LYScratchView.h
//  LYCALayer
//
//  Created by Joint on 2019/12/18.
//  Copyright © 2019 Joint. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYScratchView : UIView

/** masoicImage(放在底层) */
@property (nonatomic, strong) UIImage *mosaicImage;
/** surfaceImage(放在顶层) */
@property (nonatomic, strong) UIImage *surfaceImage;
/** 恢复 */
- (void)recover;

@end

NS_ASSUME_NONNULL_END
