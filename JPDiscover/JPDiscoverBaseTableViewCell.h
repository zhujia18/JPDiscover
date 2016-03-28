//
//  JPDiscoverBaseTableViewCell.h
//  JPDiscover
//
//  Created by Jasper on 16/3/27.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDiscoverModel.h"
#import "JPDiscoverCellBaseModule.h"
#import "JPDiscoverCellImageModule.h"

@class JPDiscoverBaseTableViewCell;

#pragma mark 事件方法

@protocol JPDiscoverTableViewCellDelegate <NSObject>

@optional
- (void)groupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell loadImageView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl placeholderImage:(NSString *)placeholderImageName;
- (void)groupTableViewCellTapImageWall:(JPDiscoverBaseTableViewCell *)tableViewCell imageWall:(JPDiscoverCellImageModule *)imageWall imageView:(UIImageView *)imageView index:(NSUInteger)index;
- (void)groupTableViewCellTapUserHead:(JPDiscoverBaseTableViewCell *)tableViewCell;
- (void)groupTableViewCellTapPraiseButton:(JPDiscoverBaseTableViewCell *)tableViewCell;
- (void)groupTableViewCellTapCommentButton:(JPDiscoverBaseTableViewCell *)tableViewCell;
- (void)groupTableViewCellTapShareContent:(JPDiscoverBaseTableViewCell *)tableViewCell;
- (void)groupTableViewCellTapVideoPlay:(JPDiscoverBaseTableViewCell *)tableViewCell;
@end

#pragma mark 数据源

@protocol JPDiscoverTableViewCellDataSource <NSObject>

@required
- (JPDiscoverTitleModel *)titleDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath;

- (JPDiscoverContentModel *)contentDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath;

- (JPDiscoverImageModel *)imageDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath;

- (JPDiscoverShareModel *)shareDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath;

- (JPDiscoverVideoModel *)videoDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath;

- (JPDiscoverCommentsModel *)commentsDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath;

@end

@interface JPDiscoverBaseTableViewCell : UITableViewCell

/**
 *  @brief  模块数组
 */
@property (nonatomic, strong) NSArray *modules;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<JPDiscoverTableViewCellDataSource>dataSource;
@property (nonatomic, weak) id<JPDiscoverTableViewCellDelegate>delegate;

/**
 *  @brief  创建cell
 *
 *  @param style           样式
 *  @param reuseIdentifier 标识
 *  @param module          模块们（传名）
 *
 *  @return cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width;
/**
 *  @brief  加载数据
 */
- (void)loadDataSourceWithIndexPath:(NSIndexPath *)indexPath;
/**
 *  @brief  计算对应内容显示的高度
 *
 *  @param model 要用来计算高度的数据源
 *  @param width 宽度
 *
 *  @return 高度
 */
+ (CGFloat)countHeightWithGroupCellModel:(JPDiscoverModel *)model width:(CGFloat)width;

@end
