//
//  JPDiscoverCellImageModule.h
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellBaseModule.h"

@interface JPDiscoverCellImageModule : JPDiscoverCellBaseModule

typedef void(^JPDiscoverTapImageBlock) (JPDiscoverCellImageModule *tapImageModule, UIImageView *tapIamgeView, NSUInteger index);

@property (nonatomic, copy) JPDiscoverTapImageBlock tapImageBlock;

/**
 *  @brief  imageView显示的尺寸
 */
@property(nonatomic, assign) CGSize imageSize;

/**
 *  @brief  定义内相邻图片间距
 */
@property(nonatomic, assign) CGSize imageSpacing;

- (id)initWithWidth:(CGFloat)widthTemp maxImageViewCount:(NSUInteger)maxCountTemp;

- (void)setDataWithModel:(JPDiscoverImageModel *)model;

- (UIImageView *)imageViewWithIndex:(NSInteger)index;

@end
