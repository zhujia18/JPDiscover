//
//  JPSlideViewControllerView.m
//  JPDiscover
//
//  Created by Jasper on 16/5/3.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPSlideViewControllerView.h"

#define removed @"removed"

@interface JPSlideViewControllerView()<UIScrollViewDelegate> {
    //数据源
    NSMutableArray *viewControllerNames;
    NSMutableArray *viewControllers;
    //参数
    NSInteger selectIndex;
    NSUInteger vcCount;
    NSMutableArray *orderRecord;
    BOOL isAnimationing;
    //UI
    UIScrollView *scrollView;
}

@end

@implementation JPSlideViewControllerView
@synthesize scrollView;
@synthesize selectIndex;

- (void)viewWillAppear:(BOOL)animated {
    UIViewController *viewWillAppearVC = [viewControllers objectAtIndex:selectIndex];
    [viewWillAppearVC viewWillAppear:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    UIViewController *viewDidAppearVC = [viewControllers objectAtIndex:selectIndex];
    [viewDidAppearVC viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    UIViewController *viewWillDisappearVC = [viewControllers objectAtIndex:selectIndex];
    [viewWillDisappearVC viewWillDisappear:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    UIViewController *viewDidDisappearVC = [viewControllers objectAtIndex:selectIndex];
    [viewDidDisappearVC viewDidDisappear:YES];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height);
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.scrollsToTop = NO;
        [self addSubview:scrollView];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setViewControllerNames:(NSString *)names,... {
    NSString *curName;
    va_list list;
    NSString *tempStr = [[NSString alloc] init];
    if(names)
    {
        tempStr = [tempStr stringByAppendingFormat:@"%@",names];
        va_start(list, names);
        while ((curName = va_arg(list, NSString *))){
            tempStr = [tempStr stringByAppendingFormat:@",%@",curName];
        }
        va_end(list);
    }
    NSArray *tempNames = [tempStr componentsSeparatedByString:@","];
    viewControllers = [[NSMutableArray alloc] init];
    viewControllerNames = [[NSMutableArray alloc] init];
    for (NSString *vcName in tempNames) {
        UIViewController *currVC = [[NSClassFromString(vcName) alloc] init];
        if (currVC) {
            [viewControllers addObject:removed];
            [viewControllerNames addObject:vcName];
        }
    }
    vcCount = [viewControllers count];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame) * [viewControllers count], CGRectGetHeight(scrollView.frame));
    [self loadSelectViewController:0 state:ViewWillAppear];
    [self loadSelectViewController:1 state:ViewWillAppear];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView {
    [self setSelectIndex:fabs(_scrollView.contentOffset.x) / _scrollView.frame.size.width];
}

- (void)loadSelectViewController:(NSUInteger)beLoadIndex state:(LoadViewState)state {
    if (!(beLoadIndex < vcCount)) {
        return;
    }
    id beLoadObj = [viewControllers objectAtIndex:beLoadIndex];
    if ([beLoadObj isKindOfClass:[NSString class]] && [(NSString *)beLoadObj isEqualToString:removed]) {
        NSString *vcName = [viewControllerNames objectAtIndex:beLoadIndex];
        UIViewController *beLoadVC = [[NSClassFromString(vcName) alloc] init];
        if (beLoadVC) {
            [scrollView addSubview:beLoadVC.view];
        }
        
        beLoadVC.view.frame = CGRectMake(beLoadIndex * CGRectGetWidth(beLoadVC.view.frame), 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame));
        beLoadVC.view.clipsToBounds = YES;
        [viewControllers replaceObjectAtIndex:beLoadIndex withObject:beLoadVC];
        switch (state) {
            case ViewWillAppear: {
                [beLoadVC viewWillAppear:YES];
                break;
            }
            case ViewDidAppear: {
                [beLoadVC viewDidAppear:YES];
                break;
            }
            case ViewWillDisappear: {
                [beLoadVC viewWillDisappear:YES];
                break;
            }
            case ViewDidDisappear: {
                [beLoadVC viewDidDisappear:YES];
                break;
            }
            default: {
                break;
            }
        }
    }else if ([beLoadObj isKindOfClass:[UIViewController class]]) {
        switch (state) {
            case ViewWillAppear: {
                [beLoadObj viewWillAppear:YES];
                break;
            }
            case ViewDidAppear: {
                [beLoadObj viewDidAppear:YES];
                break;
            }
            case ViewWillDisappear: {
                [beLoadObj viewWillDisappear:YES];
                break;
            }
            case ViewDidDisappear: {
                [beLoadObj viewDidDisappear:YES];
                break;
            }
            default: {
                break;
            }
        }
    }
}

- (void)freeViewController {
    [self processingQueuem];
    for (NSNumber *beFreeVCNum in orderRecord) {
        NSInteger index = [beFreeVCNum integerValue];
        if (index == selectIndex) {
            return;
        }
        id beFreeObj = [viewControllers objectAtIndex:index];
        if ([beFreeObj isKindOfClass:[UIViewController class]]) {
            UIViewController *beFreeVC = (UIViewController *)beFreeObj;
            [beFreeVC.view removeFromSuperview];
            beFreeObj = nil;
            beFreeVC = nil;
            [viewControllers replaceObjectAtIndex:index withObject:removed];
            break;
        }
    }
}

- (void)setSelectIndex:(NSInteger)num {
    if (selectIndex != num) {
        selectIndex = num;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        //        [self loadSelectViewController:num-1 state:ViewWillAppear];
        [self loadSelectViewController:num state:ViewDidAppear];
        //        [self loadSelectViewController:num+1 state:ViewWillAppear];
    }
}

- (void)processingQueuem {
    NSMutableArray *tempQueue = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= vcCount; i++) {
        if (selectIndex - i >= 0) {
            [tempQueue addObject:[NSNumber numberWithUnsignedInteger:selectIndex - i]];
        }
        if (selectIndex + i < vcCount) {
            [tempQueue addObject:[NSNumber numberWithUnsignedInteger:selectIndex + i]];
        }
    }
    [tempQueue insertObject:[NSNumber numberWithUnsignedInteger:selectIndex] atIndex:0];
    orderRecord = (NSMutableArray *)[[tempQueue reverseObjectEnumerator] allObjects];
}

- (void)handleMemoryWarning {
    [self freeViewController];
}

- (void)scrollToIndex:(NSInteger)index {
    if (index >= 0 && index < vcCount) {
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame) * index, 0) animated:NO];
        //        [self loadSelectViewController:index-1 state:ViewWillAppear];
        [self loadSelectViewController:index state:ViewWillAppear];
        //        [self loadSelectViewController:index+1 state:ViewWillAppear];
        selectIndex = index;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
