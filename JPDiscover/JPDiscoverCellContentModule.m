//
//  JPDiscoverCellContentView.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellContentModule.h"

@interface JPDiscoverCellContentModule() {
    UILabel *contentLabel;
    UILabel *showMore;
    //参数
    CGFloat width;
    JPDiscoverContentModel *dataSource;
}

@end

@implementation JPDiscoverCellContentModule

#pragma mark init

- (id)initWithWidth:(CGFloat)widthTemp {
    self = [super init];
    if (self) {
        width = widthTemp;
        contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        contentLabel.frame = CGRectMake(15, 0, width - 30, 116.94921875);
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = UIColorFromRGB(0x4e5257, 1);
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
    }
    return self;
}

#pragma mark setter

- (void)setDataWithModel:(JPDiscoverContentModel *)model {
    dataSource = model;
    [self refreshViewData];
}

#pragma mark getter

- (CGFloat)height {
    CGFloat totalHeight = [dataSource.content boundingRectWithSize:CGSizeMake(width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:contentLabel.font} context:nil].size.height;
    totalHeight += 10;//设计图下间距10px
    return totalHeight;
}

+ (CGFloat)countHeightWithModel:(JPDiscoverModel *)model width:(CGFloat)width {
    CGFloat totalHeight = [model.contentModel.content boundingRectWithSize:CGSizeMake(width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    totalHeight += 10;//设计图下间距10px
    return totalHeight;
}

- (void)refreshViewData {
    CGFloat totalHeight = [dataSource.content boundingRectWithSize:CGSizeMake(width - 30, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:contentLabel.font} context:nil].size.height;
    contentLabel.frame = CGRectMake(CGRectGetMinX(contentLabel.frame), CGRectGetMinY(contentLabel.frame), CGRectGetWidth(contentLabel.frame), totalHeight);
    contentLabel.text = dataSource.content;
}

@end
