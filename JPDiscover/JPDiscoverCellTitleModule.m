//
//  JPDiscoverCellTitleView.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellTitleModule.h"

@interface JPDiscoverCellTitleModule() {
    UIImageView *headIcon;
    UILabel *username;
    UILabel *time;
    //参数
    CGFloat width;
    JPDiscoverTitleModel *dataSource;
}

@end

@implementation JPDiscoverCellTitleModule

#pragma mark init

- (id)initWithWidth:(CGFloat)widthTemp {
    self = [super init];
    if (self) {
        width = widthTemp;
        headIcon = [[UIImageView alloc] init];
        headIcon.backgroundColor = [UIColor clearColor];
        headIcon.userInteractionEnabled = YES;
        headIcon.layer.cornerRadius = 15;
        headIcon.layer.masksToBounds = YES;
        headIcon.layer.shouldRasterize = YES;
        headIcon.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self addSubview:headIcon];
        
        UITapGestureRecognizer *tapHead = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHead)];
        [headIcon addGestureRecognizer:tapHead];
        
        username = [[UILabel alloc] init];
        username.backgroundColor = [UIColor clearColor];
        username.font = [UIFont systemFontOfSize:14.0f];
        username.textColor = UIColorFromRGB(0x009696, 1);
        [self addSubview:username];
        
        time = [[UILabel alloc] init];
        time.backgroundColor = [UIColor clearColor];
        time.font = [UIFont systemFontOfSize:10.0f];
        time.textColor = UIColorFromRGB(0x999999, 1);
        [self addSubview:time];
    }
    return self;
}

#pragma mark setter

- (void)setDataWithModel:(JPDiscoverTitleModel *)model {
    dataSource = model;
    [self refreshViewData];
}

#pragma mark getter

- (CGFloat)height {
    return 50;
}

+ (CGFloat)countHeightWithModel:(JPDiscoverTitleModel *)model width:(CGFloat)width {
    return 50;
}

- (void)refreshViewData {
    //载入头像
    self.loadImageBlock(headIcon, dataSource.headIconUrl, load_default_head);
    username.text = dataSource.username;
    time.text = dataSource.time;
    [self setNeedsLayout];
}

#pragma mark 事件处理

- (void)tapHead {
    self.tapHeadBlock();
}

- (void)layoutSubviews {
    [super layoutSubviews];
    headIcon.frame = CGRectMake(12, 10, 30, 30);
    CGSize usernameSize = [username.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:username.font} context:nil].size;
    username.frame = CGRectMake(CGRectGetMaxX(headIcon.frame) + 10, 10, usernameSize.width, usernameSize.height);
    time.frame = CGRectMake(CGRectGetMaxX(headIcon.frame) + 10, CGRectGetMaxY(username.frame) + 5, 90, 11);
}

@end
