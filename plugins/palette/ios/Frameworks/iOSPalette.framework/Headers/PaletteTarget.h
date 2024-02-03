//
//  TRIPPaletteTarget.h
//  Atom
//
//  Created by dylan.tang on 17/4/11.
//  Copyright © 2017年 dylan.tang All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_OPTIONS(NSInteger,PaletteTargetMode) {
    /// 默认模式，按照枚举顺序进行识别，当识别到颜色数组的个数大于6个就返回，否则继续识别下一个模式，最后返回数组个数最大的颜色集合
    /// 如果都没有达到最大的个数，则综合所有模式按照每个颜色的占比进行排序，返回颜色数组。
    DEFAULT_NON_MODE_PALETTE = 0,
    VIBRANT_PALETTE = 1 << 0,       ///< 鲜艳
    LIGHT_VIBRANT_PALETTE = 1 << 1, ///< 亮鲜艳
    DARK_VIBRANT_PALETTE = 1 << 2,  ///< 暗鲜艳
    LIGHT_MUTED_PALETTE = 1 << 3,   ///< 亮柔和
    MUTED_PALETTE = 1 << 4,         ///< 柔和
    DARK_MUTED_PALETTE = 1 << 5,    ///< 暗柔和
    ALL_MODE_PALETTE = 1 << 6,      ///< 所有模式，按照上面顺序进行计算返回字典 以及占比最大的颜色数组，综合了所有模式的。
};

@interface PaletteTarget : NSObject

- (instancetype)initWithTargetMode:(PaletteTargetMode)mode;

- (float)getMinSaturation;

- (float)getMaxSaturation;

- (float)getMinLuma;

- (float)getMaxLuma;

- (float)getSaturationWeight;

- (float)getLumaWeight;

- (float)getPopulationWeight;

- (float)getTargetSaturation;

- (float)getTargetLuma;

- (void)normalizeWeights;

- (NSString*)getTargetKey;

+ (NSString*)getTargetModeKey:(PaletteTargetMode)mode;

@end
