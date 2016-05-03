//
//  RootViewController.m
//  JPDiscover
//
//  Created by Jasper on 16/5/3.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "RootViewController.h"
#import "GlobalMacroDefinition.h"
#import "JPSlideSegmentMenu.h"
#import "JPSlideViewControllerView.h"
#import "ViewController.h"

@interface RootViewController () {
    JPSlideSegmentMenu *menu;
    JPSlideViewControllerView *vcScrollView;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    menu = [[JPSlideSegmentMenu alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44) titles:[NSArray arrayWithObjects:@"页面1", @"页面二", @"三", @"页四", nil]];
    [menu addTarget:self action:@selector(menuSelectIndexChange) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:menu];
    
    vcScrollView = [[JPSlideViewControllerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menu.frame), SCREEN_WIDTH, CGRectGetHeight(self.view.frame) - CGRectGetHeight(menu.frame))];
    [vcScrollView setViewControllerNames:@"ViewController", @"ViewController", @"ViewController", @"ViewController", nil];
    [vcScrollView addTarget:self action:@selector(vcScrollViewSelectIndexChange) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:vcScrollView];
}

- (void)vcScrollViewSelectIndexChange {
    menu.selectIndex = vcScrollView.selectIndex;
}

- (void)menuSelectIndexChange {
    [vcScrollView scrollToIndex:menu.selectIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
