//
//  JPDiscoverCellCommentView.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellCommentModule.h"

@interface JPDiscoverCellCommentModule() {
    UILabel *like;
    UILabel *likeNum;
    UILabel *comment;
    UILabel *commentNum;
    
    UIView *leftView;
    UIView *rightView;
    //参数
    CGFloat width;
    JPDiscoverCommentsModel *dataSource;
}

@end

@implementation JPDiscoverCellCommentModule

#pragma mark init

- (id)initWithWidth:(CGFloat)widthTemp {
    self = [super init];
    if (self) {
        width = widthTemp;
        CGFloat viewWidth = (width - 24) / 2;
        CGFloat originX = (viewWidth - 40) / 2;
        
        leftView = [[UIView alloc] init];
        leftView.frame = CGRectMake(12, 0, viewWidth, 38);
        leftView.backgroundColor = [UIColor clearColor];
        [self addSubview:leftView];
        
        like = [[UILabel alloc] init];
        like.backgroundColor = [UIColor clearColor];
        like.userInteractionEnabled = YES;
        like.frame = CGRectMake(originX, (38 - 18) / 2, 19, 18);
        like.font = [UIFont fontWithName:@"icomoon" size:18.0f];
        like.textColor = UIColorFromRGB(0x999999, 1);
        like.text = @"\U0000E636";
        [leftView addSubview:like];
        
        likeNum = [[UILabel alloc] init];
        likeNum.backgroundColor = [UIColor clearColor];
        likeNum.frame = CGRectMake(CGRectGetMaxX(like.frame) + 5, (38 - 18) / 2, 50, 18);
        likeNum.font = [UIFont systemFontOfSize:12.0f];
        likeNum.textColor = UIColorFromRGB(0x999999, 1);
        [leftView addSubview:likeNum];
        
        rightView = [[UIView alloc] init];
        rightView.frame = CGRectMake(12 + viewWidth, 0, viewWidth, 38);
        rightView.backgroundColor = [UIColor clearColor];
        [self addSubview:rightView];
        
        comment = [[UILabel alloc] init];
        comment.backgroundColor = [UIColor clearColor];
        comment.userInteractionEnabled = YES;
        comment.frame = CGRectMake(originX, (38 - 18) / 2, 19, 18);
        comment.font = [UIFont fontWithName:@"icomoon" size:18.0f];
        comment.textColor = UIColorFromRGB(0x999999, 1);
        comment.text = @"\U0000E63D";
        [rightView addSubview:comment];
        
        commentNum = [[UILabel alloc] init];
        commentNum.backgroundColor = [UIColor clearColor];
        commentNum.frame = CGRectMake(CGRectGetMaxX(comment.frame) + 5, (38 - 18) / 2, 50, 18);
        commentNum.font = [UIFont systemFontOfSize:12.0f];
        commentNum.textColor = UIColorFromRGB(0x999999, 1);
        [rightView addSubview:commentNum];
        
        UITapGestureRecognizer *tapPraise = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPraise)];
        [leftView addGestureRecognizer:tapPraise];
        
        UITapGestureRecognizer *tapComment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapComment)];
        [rightView addGestureRecognizer:tapComment];
    }
    return self;
}

#pragma mark 事件

- (void)tapPraise {
    [self shakeToShow:like];
    self.tapPraiseBlock();
}

- (void)tapComment {
    self.tapCommentBlock();
}

#pragma mark setter

- (void)setDataWithModel:(JPDiscoverCommentsModel *)model {
    dataSource = model;
    [self refreshViewData];
}

#pragma mark getter

- (CGFloat)height {
    return 38;
}

+ (CGFloat)countHeightWithModel:(JPDiscoverModel *)model width:(CGFloat)width {
    return 38;
}

- (void)refreshViewData {
    if (dataSource.isPraised) {
        like.textColor = UIColorFromRGB(0xfe6400, 1);
        like.text = @"\U0000E90B";
    }else {
        like.textColor = UIColorFromRGB(0x999999, 1);
        like.text = @"\U0000E636";
    }
    if (dataSource.praiseCount != 0) {
        likeNum.text = [NSString stringWithFormat:@"%ld",(long)dataSource.praiseCount];
    }else {
        likeNum.text = @"";
    }
    if (dataSource.commentCount != 0) {
        commentNum.text = [NSString stringWithFormat:@"%ld",(long)dataSource.commentCount];
    }else {
        commentNum.text = @"";
    }
}

- (void)shakeToShow:(UIView *)view {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}

@end
