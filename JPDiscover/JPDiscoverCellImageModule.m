//
//  JPDiscoverCellImageModule.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellImageModule.h"

@interface JPDiscoverCellImageModule() {
    NSUInteger maxCount;
    NSMutableArray *imageViews;
    //参数
    CGFloat width;
    JPDiscoverImageModel *dataSource;
}

@end

@implementation JPDiscoverCellImageModule

#pragma mark init

- (id)initWithWidth:(CGFloat)widthTemp maxImageViewCount:(NSUInteger)maxCountTemp {
    self = [super init];
    if (self) {
        width = widthTemp;
        maxCount = maxCountTemp;
        imageViews = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < maxCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.layer.shouldRasterize = YES;
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            [imageViews addObject:imageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [self addSubview:imageView];
        }
        _imageSpacing = CGSizeMake(4, 4);
        CGFloat imageWidth = (widthTemp - 24 - _imageSpacing.width * 2) / 3.0f;
        _imageSize = CGSizeMake(imageWidth, imageWidth);
    }
    return self;
}

#pragma mark 事件方法

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    NSUInteger idx = [imageViews indexOfObject:imageView];
    self.tapImageBlock(self,imageView,idx);
}

#pragma mark 样式方法

- (void)putImageView {
    if (dataSource.imageUrlArr.count == 1) {
        [imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *currView = obj;
            if (idx == 0) {
                NSString *firstSizeStr = [dataSource.sizeArr firstObject];
                NSArray *firstSize = [firstSizeStr componentsSeparatedByString:@"x"];
                CGFloat imageWidth = [[firstSize firstObject] floatValue];
                CGFloat imageHeight = [[firstSize lastObject] floatValue];
                CGFloat showWidth = width - 24;//左右间距各12
                CGFloat showHeight = imageHeight * showWidth / imageWidth;
                if (showHeight > showWidth) {
                    showHeight = showWidth;
                    showWidth = imageWidth * showWidth / imageHeight;
                    if(isnan(showWidth)) {
                        showWidth=0.0f;
                    }
                    if (isinf(showWidth)) {
                        showWidth=0.0f;
                    }
                    if(isnan(showHeight)) {
                        showHeight=0.0f;
                    }
                    if (isinf(showHeight)) {
                        showHeight=0.0f;
                    }
                    currView.frame = CGRectMake(12, 0, showWidth, showHeight);
                }else {
                    if(isnan(showWidth)) {
                        showWidth=0.0f;
                    }
                    if (isinf(showWidth)) {
                        showWidth=0.0f;
                    }
                    if(isnan(showHeight)) {
                        showHeight=0.0f;
                    }
                    if (isinf(showHeight)) {
                        showHeight=0.0f;
                    }
                    currView.frame = CGRectMake(12, 0, showWidth, showHeight);
                }
            }
        }];
    }else {
        __block CGPoint nextImageOrigin = CGPointMake(12, 0);
        [imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *currView = obj;
            currView.frame = CGRectMake(nextImageOrigin.x, nextImageOrigin.y, _imageSize.width, _imageSize.height);
            if (CGRectGetMaxX(currView.frame) + _imageSpacing.width + _imageSize.width <= width) {
                //如果本行还能显示
                nextImageOrigin.x += _imageSpacing.width + _imageSize.width;
            }else {
                //换行显示
                nextImageOrigin.x = 12;
                nextImageOrigin.y += _imageSpacing.height + _imageSize.height;
            }
        }];
    }
}

#pragma mark setter

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
}

- (void)setImageSpacing:(CGSize)imageSpacing {
    _imageSpacing = imageSpacing;
}

- (void)setDataWithModel:(JPDiscoverImageModel *)model {
    dataSource = model;
    [self refreshViewData];
}

#pragma mark getter

- (CGFloat)height {
    if (dataSource.imageUrlArr.count == 0) {
        return 0;
    }else if (dataSource.imageUrlArr.count == 1) {
        NSString *firstSizeStr = [dataSource.sizeArr firstObject];
        NSArray *firstSize = [firstSizeStr componentsSeparatedByString:@"x"];
        CGFloat imageWidth = [[firstSize firstObject] floatValue];
        CGFloat imageHeight = [[firstSize lastObject] floatValue];
        CGFloat showWidth = width - 24;//左右间距各12
        CGFloat showHeight = imageHeight * showWidth / imageWidth;
        if (showHeight > showWidth) {
            showHeight = showWidth;
        }
        if(isnan(showHeight)) {
            showHeight=0.0f;
        }
        if (isinf(showHeight)) {
            showHeight=0.0f;
        }
        return showHeight;
    }else {
        UIView *lastView = [imageViews objectAtIndex:dataSource.imageUrlArr.count - 1];
        CGFloat totalHeight = CGRectGetMaxY(lastView.frame);
        return ceil(totalHeight);
    }
}

- (UIImageView *)imageViewWithIndex:(NSInteger)index {
    UIImageView *imageView = [imageViews objectAtIndex:index];
    return imageView;
}

+ (CGFloat)countHeightWithModel:(JPDiscoverModel *)model width:(CGFloat)width {
    if (model.imageModel.imageUrlArr.count == 0) {
        return 0;
    }else if (model.imageModel.imageUrlArr.count == 1) {
        NSString *firstSizeStr = [model.imageModel.sizeArr firstObject];
        NSArray *firstSize = [firstSizeStr componentsSeparatedByString:@"x"];
        CGFloat imageWidth = [[firstSize firstObject] floatValue];
        CGFloat imageHeight = [[firstSize lastObject] floatValue];
        CGFloat showWidth = width - 24;//左右间距各12
        CGFloat showHeight = imageHeight * showWidth / imageWidth;
        if (showHeight > showWidth) {
            showHeight = showWidth;
        }
        if(isnan(showHeight)) {
            showHeight=0.0f;
        }
        if (isinf(showHeight)) {
            showHeight=0.0f;
        }
        return showHeight;
    }else {
        CGSize imageSpacing = CGSizeMake(4, 4);
        CGFloat imageWidth = (width - 24 - imageSpacing.width * 2) / 3.0f;
        CGSize imageSize = CGSizeMake(imageWidth, imageWidth);
        __block CGPoint nextImageOrigin = CGPointMake(12, 0);
        __block CGRect nextRect;
        __block CGFloat maxHeight = 0;
        [model.imageModel.imageUrlArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            nextRect = CGRectMake(nextImageOrigin.x, nextImageOrigin.y, imageSize.width, imageSize.height);
            if (CGRectGetMaxX(nextRect) + imageSpacing.width + imageSize.width <= width) {
                //如果本行还能显示
                nextImageOrigin.x += imageSpacing.width + imageSize.width;
            }else {
                //换行显示
                nextImageOrigin.x = 12;
                nextImageOrigin.y += imageSpacing.height + imageSize.height;
            }
            maxHeight = CGRectGetMaxY(nextRect);
        }];
        return ceil(maxHeight);
    }
}

- (void)refreshViewData {
    if (dataSource) {
        self.hidden = NO;
    }else {
        self.hidden = YES;
    }
    __weak __typeof(&*self)weakSelf = self;
    [imageViews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *currView = obj;
        if (idx < [dataSource.imageUrlArr count]) {
            currView.hidden = NO;
            NSString *imageUrl;
            if (dataSource.imageUrlArr.count == 1) {
                imageUrl = [dataSource.imageUrlArr objectAtIndex:idx];
            }else {
                imageUrl = [dataSource.imageUrlArr objectAtIndex:idx];
            }
            weakSelf.loadImageBlock(currView, imageUrl, load_default_image);
        }else {
            currView.hidden = YES;
        }
    }];
    [self putImageView];
}

@end
