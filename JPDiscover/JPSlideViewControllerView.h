//
//  JPSlideViewControllerView.h
//  JPDiscover
//
//  Created by Jasper on 16/5/3.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoadViewState) {
    ViewWillAppear,
    ViewDidAppear,
    ViewWillDisappear,
    ViewDidDisappear,
};

@interface JPSlideViewControllerView : UIControl

@property (nonatomic, assign) LoadViewState _loadViewState;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger selectIndex;
/**
 *  @brief  根据传入的VC类名创建滑动ScrollView
 *
 *  @param names 可变参数，VC类名
 */
- (void)setViewControllerNames:(NSString *)names,...;

/**
 *  @brief  根据传入的索引滑动到对应的页面
 *
 *  @param index 要滑动到的目标索引
 */
- (void)scrollToIndex:(NSInteger)index;

- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

@end
