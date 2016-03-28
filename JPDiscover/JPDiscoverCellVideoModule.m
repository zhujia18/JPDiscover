//
//  JPDiscoverCellVideoModule.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellVideoModule.h"

@interface JPDiscoverCellVideoModule() {
    UIImageView *thumImage;
    //参数
    CGFloat width;
    UILabel *playIcon;
    JPDiscoverVideoModel *dataSource;
}

@end

@implementation JPDiscoverCellVideoModule

#pragma mark init

- (id)initWithWidth:(CGFloat)widthTemp {
    self = [super init];
    if (self) {
        width = widthTemp;
        thumImage = [[UIImageView alloc] init];
        thumImage.contentMode = UIViewContentModeScaleAspectFill;
        thumImage.clipsToBounds = YES;
        thumImage.layer.shouldRasterize = YES;
        thumImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
        thumImage.userInteractionEnabled = YES;
        [self addSubview:thumImage];
        
        playIcon = [[UILabel alloc] init];
        playIcon.backgroundColor = [UIColor clearColor];
        playIcon.userInteractionEnabled = YES;
        playIcon.font = [UIFont fontWithName:@"icomoon" size:35.0f];
        playIcon.textAlignment = NSTextAlignmentCenter;
        playIcon.textColor = [UIColor whiteColor];
        playIcon.text = @"\U0000E650";
        [thumImage addSubview:playIcon];
        
        UITapGestureRecognizer *tapPlay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlay)];
        [thumImage addGestureRecognizer:tapPlay];
    }
    return self;
}

#pragma mark setter

- (void)setDataWithModel:(JPDiscoverVideoModel *)model {
    dataSource = model;
    [self refreshViewData];
}

#pragma mark getter

- (CGFloat)height {
    CGFloat showWidth = width - 24;//左右间距各12
    CGFloat showHeight = dataSource.height * showWidth / dataSource.width;
    if (showHeight > showWidth) {
        showHeight = showWidth;
    }
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
    return showHeight;
}

+ (CGFloat)countHeightWithModel:(JPDiscoverModel *)model width:(CGFloat)width {
    CGFloat showWidth = width - 24;//左右间距各12
    CGFloat showHeight = model.videoModel.height * showWidth / model.videoModel.width;
    if (showHeight > showWidth) {
        showHeight = showWidth;
    }
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
    return showHeight;
}

#pragma mark 事件方法

- (void)tapPlay {
    self.playVideoBlock();
}

#pragma mark 样式方法

- (void)putImageView {
    CGFloat showWidth = width - 24;//左右间距各12
    CGFloat showHeight = dataSource.height * showWidth / dataSource.width;
    if (showHeight > showWidth) {
        showHeight = showWidth;
        showWidth = dataSource.width * showWidth / dataSource.height;
    }
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
    thumImage.frame = CGRectMake(12, 0, showWidth, showHeight);
    playIcon.frame = CGRectMake((CGRectGetWidth(thumImage.frame) - 40) / 2, (CGRectGetHeight(thumImage.frame) - 40) / 2, 40, 40);
}

- (void)refreshViewData {
    if (dataSource) {
        self.hidden = NO;
    }else {
        self.hidden = YES;
    }
    //设置缩略图
    self.loadImageBlock(thumImage, dataSource.thumImageUrl, load_default_image);
    [self putImageView];
}

@end
