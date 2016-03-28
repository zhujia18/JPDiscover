//
//  JPDiscoverModel.h
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark cell的model

@class JPDiscoverTitleModel;
@class JPDiscoverContentModel;
@class JPDiscoverImageModel;
@class JPDiscoverShareModel;
@class JPDiscoverVideoModel;
@class JPDiscoverCommentsModel;

@interface JPDiscoverModel : NSObject

@property (nonatomic, strong) JPDiscoverTitleModel *titleModel;
@property (nonatomic, strong) JPDiscoverContentModel *contentModel;
@property (nonatomic, strong) JPDiscoverImageModel *imageModel;
@property (nonatomic, strong) JPDiscoverShareModel *shareModel;
@property (nonatomic, strong) JPDiscoverVideoModel *videoModel;
@property (nonatomic, strong) JPDiscoverCommentsModel *commentsModel;

+ (JPDiscoverModel *)getTestModel;

@end

#pragma mark 标题模块model

@interface JPDiscoverTitleModel : NSObject
/**
 *  @brief  头像URL
 */
@property (nonatomic, strong) NSString *headIconUrl;
/**
 *  @brief  用户名
 */
@property (nonatomic, strong) NSString *username;
/**
 *  @brief  时间
 */
@property (nonatomic, strong) NSString *time;

+ (JPDiscoverTitleModel *)getTestModel;

@end

#pragma mark 文本主题模块model

@interface JPDiscoverContentModel : NSObject
/**
 *  @brief  主体文本内容
 */
@property (nonatomic, strong) NSString *content;

+ (JPDiscoverContentModel *)getTestModel;

@end

#pragma mark 图片模块model

@interface JPDiscoverImageModel : NSObject
/**
 *  @brief  图片URL数组
 */
@property (nonatomic, strong) NSArray *imageUrlArr;
/**
 *  @brief  宽和高的数组，元素示例 123x456
 */
@property (nonatomic, strong) NSArray *sizeArr;

+ (JPDiscoverImageModel *)getTestModel;

@end

#pragma mark 分享模块model

@interface JPDiscoverShareModel : NSObject
/**
 *  @brief  缩略图URL
 */
@property (nonatomic, strong) NSString *thumImageUrl;
/**
 *  @brief  标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  @brief  简介
 */
@property (nonatomic, strong) NSString *summary;
/**
 *  @brief  单击后跳转的目标地址
 */
@property (nonatomic, strong) NSString *uri;

+ (JPDiscoverShareModel *)getTestModel;

@end

#pragma mark 视频模块model

@interface JPDiscoverVideoModel : NSObject
/**
 *  @brief  视频名字
 */
@property (nonatomic, strong) NSString *name;
/**
 *  @brief  视频持续时间
 */
@property (nonatomic, strong) NSString *duration;
/**
 *  @brief  缩略图URL
 */
@property (nonatomic, strong) NSString *thumImageUrl;
/**
 *  @brief  视频URL
 */
@property (nonatomic, strong) NSString *videoUrl;
/**
 *  @brief  视频宽
 */
@property (nonatomic, assign) NSInteger width;
/**
 *  @brief  视频高
 */
@property (nonatomic, assign) NSInteger height;

+ (JPDiscoverVideoModel *)getTestModel;

@end

#pragma mark 评论点赞模块model

@interface JPDiscoverCommentsModel : NSObject
/**
 *  @brief  我是否赞了该话题
 */
@property (nonatomic, assign) BOOL isPraised;
/**
 *  @brief  点赞总数
 */
@property (nonatomic, assign) NSInteger praiseCount;
/**
 *  @brief  评论总数
 */
@property (nonatomic, assign) NSInteger commentCount;

+ (JPDiscoverCommentsModel *)getTestModel;

@end