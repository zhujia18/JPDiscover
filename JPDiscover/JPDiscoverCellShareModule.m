//
//  JPDiscoverCellShareModule.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellShareModule.h"

@interface JPDiscoverCellShareModule() {
    UIView *backgroundView;
    UIImageView *thumImage;
    UILabel *title;
    UILabel *content;
    //参数
    CGFloat width;
    JPDiscoverShareModel *dataSource;
}

@end

@implementation JPDiscoverCellShareModule

#pragma mark init

- (id)initWithWidth:(CGFloat)widthTemp {
    self = [super init];
    if (self) {
        width = widthTemp;
        backgroundView = [[UIView alloc] init];
        backgroundView.frame = CGRectMake(8, 0, width - 16, 72);
        backgroundView.backgroundColor = UIColorFromRGB(0xf8f8f8, 1);
        [self addSubview:backgroundView];
        
        thumImage = [[UIImageView alloc] init];
        thumImage.frame = CGRectMake(4, 4, 64, 64);
        thumImage.contentMode = UIViewContentModeScaleAspectFill;
        thumImage.clipsToBounds = YES;
        thumImage.layer.shouldRasterize = YES;
        thumImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [backgroundView addSubview:thumImage];
        
        title = [[UILabel alloc] init];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:14.0f];
        title.textColor = UIColorFromRGB(0x4e5257, 1);
        title.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [backgroundView addSubview:title];
        
        content = [[UILabel alloc] init];
        content.backgroundColor = [UIColor clearColor];
        content.font = [UIFont systemFontOfSize:12.0f];
        content.textColor = UIColorFromRGB(0x999999, 1);
        content.numberOfLines = 2;
        content.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [backgroundView addSubview:content];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark setter

- (void)setDataWithModel:(JPDiscoverShareModel *)model {
    dataSource = model;
    [self refreshViewData];
}

#pragma mark getter

- (CGFloat)height {
    if (dataSource) {
        return 72;
    }else {
        return 0;
    }
}

+ (CGFloat)countHeightWithModel:(JPDiscoverModel *)model width:(CGFloat)width {
    if (model.shareModel) {
        return 72;
    }else {
        return 0;
    }
}

#pragma mark 事件

- (void)tapSelf {
    self.tapBlock();
}

- (void)refreshViewData {
    if (dataSource) {
        self.hidden = NO;
    }else {
        self.hidden = YES;
    }
    //设置缩略图
    self.loadImageBlock(thumImage, dataSource.thumImageUrl, load_default_image);
    
    //设置标题
    title.frame = CGRectMake(CGRectGetMaxX(thumImage.frame) + 10, 8, CGRectGetWidth(backgroundView.frame) - (CGRectGetMaxX(thumImage.frame) + 10) - 10, 0);
    title.text = dataSource.title;
    [title sizeToFit];
    
    //设置摘要
    if (CGRectGetHeight(title.frame) < 1) {
        content.frame = CGRectMake(CGRectGetMaxX(thumImage.frame) + 10, CGRectGetMaxY(title.frame), CGRectGetWidth(backgroundView.frame) - (CGRectGetMaxX(thumImage.frame) + 10) - 10, 0);
        content.numberOfLines = 3;
    }else {
        content.frame = CGRectMake(CGRectGetMaxX(thumImage.frame) + 10, CGRectGetMaxY(title.frame) + 8, CGRectGetWidth(backgroundView.frame) - (CGRectGetMaxX(thumImage.frame) + 10) - 10, 0);
        content.numberOfLines = 2;
    }
    
    if (dataSource.summary) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:dataSource.summary];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];//调整行间距
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, [dataSource.summary length])];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [dataSource.summary length])];
        content.attributedText = attributedString;
        [content sizeToFit];
    }
}

@end
