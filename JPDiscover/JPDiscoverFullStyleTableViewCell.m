//
//  JPDiscoverFullStyleTableViewCell.m
//  JPDiscover
//
//  Created by Jasper on 16/3/27.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverFullStyleTableViewCell.h"
#import "JPDiscoverCellTitleModule.h"
#import "JPDiscoverCellContentModule.h"
#import "JPDiscoverCellImageModule.h"
#import "JPDiscoverCellVideoModule.h"
#import "JPDiscoverCellShareModule.h"
#import "JPDiscoverCellCommentModule.h"

@interface JPDiscoverFullStyleTableViewCell() {
    JPDiscoverCellTitleModule *titleView;
    JPDiscoverCellContentModule *contentView;
    JPDiscoverCellImageModule *imageWall;
    JPDiscoverCellVideoModule *videoView;
    JPDiscoverCellShareModule *shareView;
    JPDiscoverCellCommentModule *commentView;
}

@end

@implementation JPDiscoverFullStyleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initTitle:width];
        [self initContent:width];
        [self initImage:width];
        [self initVideo:width];
        [self initShare:width];
        [self initComment:width];
        self.modules = [NSArray arrayWithObjects:titleView, contentView, imageWall, videoView, shareView, commentView, nil];
    }
    return self;
}

#pragma mark init & add

- (void)initTitle:(CGFloat)width {
    __weak __typeof(&*self)weakSelf = self;
    titleView = [[JPDiscoverCellTitleModule alloc] initWithWidth:width];
    titleView.loadImageBlock = ^(UIImageView *beLoadIamgeView, NSString *beLoadImageUrlStr, NSString *placeholderImageName) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCell:loadImageView:imageUrl:placeholderImage:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadImageView:beLoadIamgeView imageUrl:beLoadImageUrlStr placeholderImage:placeholderImageName];
        }
    };
    titleView.tapHeadBlock = ^() {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(groupTableViewCellTapUserHead:)]) {
            [weakSelf.delegate groupTableViewCellTapUserHead:weakSelf];
        }
    };
    [self.contentView addSubview:titleView];
}

- (void)initContent:(CGFloat)width {
    contentView = [[JPDiscoverCellContentModule alloc] initWithWidth:width];
    [self.contentView addSubview:contentView];
}

- (void)initImage:(CGFloat)width {
    __weak __typeof(&*self)weakSelf = self;
    imageWall = [[JPDiscoverCellImageModule alloc] initWithWidth:width maxImageViewCount:9];
    imageWall.imageSpacing = CGSizeMake(4, 4);
    imageWall.loadImageBlock = ^(UIImageView *beLoadIamgeView, NSString *beLoadImageUrlStr, NSString *placeholderImageName) {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCell:loadImageView:imageUrl:placeholderImage:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadImageView:beLoadIamgeView imageUrl:beLoadImageUrlStr placeholderImage:placeholderImageName];
        }
    };
    imageWall.tapImageBlock = ^(JPDiscoverCellImageModule *tapImageWall, UIImageView *tapIamgeView, NSUInteger index) {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCellTapImageWall:imageWall:imageView:index:)]) {
            [weakSelf.delegate groupTableViewCellTapImageWall:weakSelf imageWall:tapImageWall imageView:tapIamgeView index:index];
        }
    };
    [self.contentView addSubview:imageWall];
}

- (void)initVideo:(CGFloat)width {
    __weak __typeof(&*self)weakSelf = self;
    videoView = [[JPDiscoverCellVideoModule alloc] initWithWidth:width];
    videoView.loadImageBlock = ^(UIImageView *beLoadIamgeView, NSString *beLoadImageUrlStr, NSString *placeholderImageName) {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCell:loadImageView:imageUrl:placeholderImage:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadImageView:beLoadIamgeView imageUrl:beLoadImageUrlStr placeholderImage:placeholderImageName];
        }
    };
    videoView.playVideoBlock =  ^() {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCellTapVideoPlay:)]) {
            [weakSelf.delegate groupTableViewCellTapVideoPlay:weakSelf];
        }
    };
    [self.contentView addSubview:videoView];
}

- (void)initShare:(CGFloat)width {
    __weak __typeof(&*self)weakSelf = self;
    shareView = [[JPDiscoverCellShareModule alloc] initWithWidth:width];
    shareView.loadImageBlock = ^(UIImageView *beLoadIamgeView, NSString *beLoadImageUrlStr, NSString *placeholderImageName) {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCell:loadImageView:imageUrl:placeholderImage:)]) {
            [weakSelf.delegate groupTableViewCell:weakSelf loadImageView:beLoadIamgeView imageUrl:beLoadImageUrlStr placeholderImage:placeholderImageName];
        }
    };
    shareView.tapBlock = ^() {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCellTapShareContent:)]) {
            [weakSelf.delegate groupTableViewCellTapShareContent:weakSelf];
        }
    };
    [self.contentView addSubview:shareView];
}

- (void)initComment:(CGFloat)width {
    __weak __typeof(&*self)weakSelf = self;
    commentView = [[JPDiscoverCellCommentModule alloc] initWithWidth:width];
    commentView.tapPraiseBlock = ^() {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCellTapPraiseButton:)]) {
            [weakSelf.delegate groupTableViewCellTapPraiseButton:weakSelf];
        }
    };
    commentView.tapCommentBlock = ^() {
        if (weakSelf.delegate && [weakSelf.dataSource respondsToSelector:@selector(groupTableViewCellTapCommentButton:)]) {
            [weakSelf.delegate groupTableViewCellTapCommentButton:weakSelf];
        }
    };
    [self.contentView addSubview:commentView];
}

#pragma mark loadData

- (void)loadDataSourceWithIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleDataForGroupTableViewCell:indexPath:)]) {
        JPDiscoverTitleModel *titleModel = [self.dataSource titleDataForGroupTableViewCell:self indexPath:self.indexPath];
        [titleView setDataWithModel:titleModel];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(contentDataForGroupTableViewCell:indexPath:)]) {
        JPDiscoverContentModel *contentModel = [self.dataSource contentDataForGroupTableViewCell:self indexPath:self.indexPath];
        [contentView setDataWithModel:contentModel];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(imageDataForGroupTableViewCell:indexPath:)]) {
        JPDiscoverImageModel *imageModel = [self.dataSource imageDataForGroupTableViewCell:self indexPath:self.indexPath];
        [imageWall setDataWithModel:imageModel];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(shareDataForGroupTableViewCell:indexPath:)]) {
        JPDiscoverShareModel *shareModel = [self.dataSource shareDataForGroupTableViewCell:self indexPath:self.indexPath];
        [shareView setDataWithModel:shareModel];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(videoDataForGroupTableViewCell:indexPath:)]) {
        JPDiscoverVideoModel *videoModel = [self.dataSource videoDataForGroupTableViewCell:self indexPath:self.indexPath];
        [videoView setDataWithModel:videoModel];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(commentsDataForGroupTableViewCell:indexPath:)]) {
        JPDiscoverCommentsModel *commentModel = [self.dataSource commentsDataForGroupTableViewCell:self indexPath:self.indexPath];
        [commentView setDataWithModel:commentModel];
    }
}

+ (CGFloat)countHeightWithGroupCellModel:(JPDiscoverModel *)model width:(CGFloat)width {
    CGFloat totalHeight = 0;
    totalHeight += [JPDiscoverCellTitleModule  countHeightWithModel:model width:width];
    totalHeight += [JPDiscoverCellContentModule countHeightWithModel:model width:width];
    totalHeight += [JPDiscoverCellImageModule countHeightWithModel:model width:width];
    totalHeight += [JPDiscoverCellShareModule  countHeightWithModel:model width:width];
    totalHeight += [JPDiscoverCellVideoModule countHeightWithModel:model width:width];
    totalHeight += [JPDiscoverCellCommentModule  countHeightWithModel:model width:width];
    totalHeight += 10;//cell之间的间距
    return totalHeight;
}

@end
