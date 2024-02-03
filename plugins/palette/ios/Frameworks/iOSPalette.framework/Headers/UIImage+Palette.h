//
//  UIImage+Palette.h
//  Atom
//
//  Created by dylan.tang on 17/4/20.
//  Copyright © 2017年 dylan.tang All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Palette.h"

@interface UIImage (Palette)

/// 默认模式，按照枚举顺序进行识别，当识别到颜色数组的个数大于6个就返回，否则继续识别下一个模式，最后返回数组个数最大的颜色集合
/// 如果都没有达到最大的个数，则综合所有模式按照每个颜色的占比进行排序，返回颜色数组。
/// @param block 完成回调
- (void)getPaletteImageColor:(GetColorBlock)block;

/// 特定模式识别返回的颜色数组
/// @param mode 某个模式， 可以用 '|' 并起来， 如果是默认模式，按照枚举顺序进行识别，当识别到颜色数组的个数大于6个就返回，否则继续识别下一个模式，最后返回数组个数最大的颜色集合，     如果都没有达到最大的个数，则综合所有模式按照每个颜色的占比进行排序，返回颜色数组。    如果是ALL模式，会综合了所有模式返回占比最大的颜色数组以及各个模式对应的颜色数组。
/// @param block 返回Block
- (void)getPaletteImageColorWithMode:(PaletteTargetMode)mode withCallBack:(GetColorBlock)block;

@end
